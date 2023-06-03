import { buildHTML } from "./add_schedule";
const createTimeArea = (schedule) => {  
  const timeAreas = [];
  schedule.forEach(event => {
    const regTarget1 = /2000-01-01T/;
    const regTarget2 = /:00.000\+09:00/;
  
    let start = event.started_at;
    start = start.replace(regTarget1, "");
    start = start.replace(regTarget2, "");
  
    let finish = event.finished_at;
    finish = finish.replace(regTarget1, "");
    finish = finish.replace(regTarget2, "");
  
    const startParts = start.split(":");
    const startHour = parseInt(startParts[0], 10);
    const startMin = parseInt(startParts[1], 10);
    const startTime = (startHour * 60) + startMin;
    
    const finishParts = finish.split(":");
    const finishHour = parseInt(finishParts[0], 10);
    const finishMin = parseInt(finishParts[1], 10);
    const finishTime = (finishHour * 60) + finishMin;

    if(startTime > finishTime){
      for(let i = startTime; i == 1359; i++ ){
        timeAreas.push(i);
      }
      for(let i = 0; i < finishTime; i++ ){
        timeAreas.push(i);
      }
    }
    
    for(let i = startTime; i < finishTime; i++ ){
      timeAreas.push(i);
    };
  });
  return timeAreas
};


const createHTML = (response) => {
  const dayOfMinutes = 60 * 24;
  let minuteArray = [];
  for(let i = 0; i < dayOfMinutes; i++ ){
    minuteArray.push(i);
  };

  const user = response.user;
  const schedules = response.schedules;
  const week = response.week;

  const timeArea = createTimeArea(schedules);
  const outOfEvents = [];
  minuteArray.forEach(time => {
    if(!timeArea.includes(time)){
      outOfEvents.push(time);
    }
  });

  const listHead = `
    <div class="your-schedule">
      <p>${user.nickname}さんの${week.attributes.name}スケジュール</p>
    </div><br>
    `;
  const html = buildHTML(schedules);
  const blankHTML = `
    <div class="blank-time">
      <p>一日${outOfEvents.length}分の空き時間があります！ぜひ有効活用しましょう！</p>
    </div><br>`;
  return {html, listHead, blankHTML}
};

const onload = (xhr) => {
  xhr.onload = () => {
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
  };
};

const list = () => {
  const url = window.location.href;
  if(url.match(/schedules$/)){
    const weekdayBtn = document.getElementById('weekday-btn');
    const holidayBtn = document.getElementById('holiday-btn');

    holidayBtn.addEventListener('click', (e) => {
      e.preventDefault();
      const xhr = new XMLHttpRequest();
      let params = 'week_id=3';
      xhr.open("GET", url + "?" + params, true);
      xhr.responseType = "json";
      xhr.send();
      onload(xhr);
    });

    weekdayBtn.addEventListener('click', (e) => {
      e.preventDefault();
      const xhr = new XMLHttpRequest();
      let params = 'week_id=2';
      xhr.open("GET", url + "?" + params, true);
      xhr.responseType = "json";
      xhr.send();
      onload(xhr);
    });
  }
};

window.addEventListener('load', list);