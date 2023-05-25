

// total関数でラジオボタンの値の取得と合計を行う
const total = function(){
  q1 = document.getElementsByName('q1');
  q1_len = q1.length;
  
    for(i = 0; i < q1_len; i++ ){
      q1[i].addEventListener('click', () =>
      {
        console.log(q1[i] + 'is checked');
      });
    }
};

window.addEventListener('load', total);