// total関数でラジオボタンの値の取得と合計を行う
const total = function(){
  const submit = document.getElementById('submit');
  submit.addEventListener('click', (e) => {
    e.preventDefault();

    const answers = [];
    const questions = [];

    for(i = 1; i < 11; i++){
      questions.push('q' + i);
    }

    
    const qList = [];
    questions.forEach((q) => {
      qList.push(document.getElementsByName(q));
    });
    
    qList.forEach((q) => {
      for(i = 0; i < q.length; i++){
        if(q[i].checked){
          answers.push(q[i].value);
        }
      }
    });

    const scores = [];
    answers.forEach((e) => {
      if(e == "yes"){
        scores.push(1);
      } else if(e == "neither"){
        scores.push(2);
      } else if(e == "no"){
        scores.push(3);
      }
    });

    totalPoints = 0;
    for(i = 0; i < scores.length; i++){
      totalPoints += scores[i];
    }

    console.log(totalPoints);
  });
};

window.addEventListener('load', total);