import { createHTML } from "./schedule_list";
export const buildHTML = (events) => {
  const htmlContainer = [];
  events.forEach(event => {
    const regTarget1 = /2000-01-01T/;
    const regTarget2 = /:00.000\+09:00/;

    let start = event.started_at;
    start = start.replace(regTarget1, "");
    start = start.replace(regTarget2, "");

    let finish = event.finished_at;
    finish = finish.replace(regTarget1, "");
    finish = finish.replace(regTarget2, "");
    
    const html = `
      <div class="event-wrapper">
        <div class="time-data">
          <div class="start-time">
            ${start}<span>〜</span>
          </div>
          <div class="finish-time">
            ${finish}
          </div>
        </div>
        <div class="event-label">
        ${event.event_name}
        </div>
        <input type="submit" value="削除" class="event-delete-btn" id="${event.id}">
        </div>`;
        htmlContainer.push(html);
      });
      return htmlContainer
    };
    
export const deleteEvent = () => {
  const deleteBtn = document.getElementsByClassName('event-delete-btn');
  let url = window.location.href;
  url = url.replace(/\/new/, "");
  const xhr = new XMLHttpRequest();
  Array.from(deleteBtn).forEach(btn => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();

      const targetId = btn.id;
      const token = document.querySelector('meta[name="csrf-token"]').content;
      
      xhr.open("DELETE", url + "/" + targetId, true);
      xhr.responseType = "json";
      xhr.setRequestHeader("X-CSRF-Token", token);
      xhr.send();
      
      if(window.location.href.match(/new/)){
        url += "new";
      }
      xhr.onload = () => {renderingView(url, xhr)
      }
    });
  });
};

const renderingView = (url, xhr) => {
  if(url.match(/new$/)){
    console.log(xhr.response);
    const events = xhr.response.schedules;
    const list = document.getElementById('schedule-list');
    list.innerHTML = "";
    const html = buildHTML(events);
    html.forEach(element => {
      element += "<br>";
      list.insertAdjacentHTML('afterbegin', element);
    });
    const formValue1 = document.getElementById('event_name');
    const formValue2 = document.getElementById('started_at');
    const formValue3 = document.getElementById('finished_at');
    
    formValue1.value = "";
    formValue2.value = "";
    formValue3.value = "";
    const selectWeek = document.getElementById('select-week');
    selectWeek.style.display = "none";

  } else {
    const listContainer = document.getElementById('list-container');
    const blankContainer = document.getElementById('blank-container');
    listContainer.style.display = "block";
    blankContainer.style.display = "block";
    listContainer.innerHTML = "";
    blankContainer.innerHTML = "";
    const response = xhr.response
    const {html, listHead, blankHTML} = createHTML(response);
    html.forEach(element => {
      element += "<br>";
      listContainer.insertAdjacentHTML('afterbegin', element);
    });
    
    listContainer.insertAdjacentHTML('afterbegin', listHead);
    blankContainer.insertAdjacentHTML('afterbegin', blankHTML);
  }
  deleteEvent();
};

const onload = (xhr) => {
  xhr.onload = () => {
    const events = xhr.response.schedules;
    const list = document.getElementById('schedule-list');
    list.innerHTML = "";
    const html = buildHTML(events);
    html.forEach(element => {
      element += "<br>";
      list.insertAdjacentHTML('afterbegin', element);
    });
    deleteEvent();
    const formValue1 = document.getElementById('event_name');
    const formValue2 = document.getElementById('started_at');
    const formValue3 = document.getElementById('finished_at');
    
    formValue1.value = "";
    formValue2.value = "";
    formValue3.value = "";
    const selectWeek = document.getElementById('select-week');
    selectWeek.style.display = "none";
  };
};

const add = function() {
  const currentUrl = window.location.href;
  if(currentUrl.match(/schedules\/new/)){
    const submit = document.getElementById('event-submit');
    submit.addEventListener('click', (e) => {
      e.preventDefault();
      const url = currentUrl.replace(/\/new/, "");
      const form = document.getElementById('schedule-form');
      const formData = new FormData(form);
      const xhr = new XMLHttpRequest();
      xhr.open("POST", url, true);
      xhr.responseType = "json";
      xhr.send(formData);
      onload(xhr);
    });
  }
};

window.addEventListener('load', add);