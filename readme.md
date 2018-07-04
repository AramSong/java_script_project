### 웹 브라우저의 HTML 문서 렌더링 과정

1. 불러오기

   로더가 서버로부터 전달 받는 리소스 스트림을 읽는 과정. 읽으면서 어떤 파일인지, 데이터 인지 파일을 다운로드할 것인지 등을 결정한다. HTML 파싱과 DOM 트리 구성 사용자가 페이지를 요청하면 네트워크를 통해 마크업을 받아온다.

2. 파싱

   마크업 문자열을 토큰 형태로 잘라서(Tokenizer)트리를 구축하고 파싱 작업을 시작한다. 그 다음 웹 엔진이 가지고 있는 HTML/XML 파서가 문서를 파싱해서 DOM Tree를 만든다.

3. 렌더링 트리 만들기

   DOM Tree는 내용을 저장하는 트리로 자바스크립트에서 접근하는 DOM객체를 쓸 때 이용하는 것이고 별도로 그리기 위한 트리가 만들어져야 하는데 그것이 렌더링 트리다. ( 그릴 때 필요없는 head,title,body 태그등이 없음 + display:none처럼 DOM에는 있지만 화면에서는 필요없는 부분을 걸러낸다.)

4. CSS 결정

   CSS는 선택자에 따라서 적용되는 태그가 다르기 때문에 모든 CSS 스타일을 분석해 태그에 스타일 규칙이 적용되게 결정한다.

5. 레이아웃

   렌더링 트리에서 위치나 크기를 가지고 있지 않기 때문에 객체들에게 위치와 크기를 정해주는 과정.

6. 그리기

   렌더링 트리를 탐색하면서 그리기 (참고로 렌더링 엔진은 가능하면 HTML 문서가 파싱될 때 까지 기다리지 않고, 배치와 그리기 과정을 시작한다. ) 렌더 트리 그리기 요소의 좌표가 설정되면 브라우저에 순차적으로 화면을 그린다. 이 때 사용자는 화면을 조금씩 보게 된다. 

   *출처 : http://jeong-pro.tistory.com/90*

   *출처: http://wikibook.co.kr/article/web-sites-optimization-3/#fn:19*  

   *DOM : Document Object Model. HTML,XML문서의 프로그래밍 interface*

   

------

# jQuery

#### 이벤트 리스너

- 요소에 이벤트가 발생했을 때, 해당 이벤트가 발생했는지 감지하는 것을 이벤트 리스너라고 한다. 만약 `버튼을 클릭하다.` 라고 했을 때, `버튼`은 요소가 되고 `클릭하다`는 이벤트가 된다. 이벤트 리스너는 `버튼을 클릭했을 때`를 감지한다고 할 수 있겠다.
- 요소에 이벤트 리스너를 추가하는 방법에는 두가지가 있다.

```
btn.onclick = function() {
    ...
};
btn.addEventListener('click', function() {
    ...
})
```

- 함수에 대해서는 차차 이야기 하겠지만 `function() {}` 부분이 바로 자바스크립트 함수에 해당한다.

- jQuery(요소 선택자,이벤트 리스너)

  `$("css 선택자")`

```javascript
jQuery.fn.init [prevObject: jQuery.fn.init(1), context: document, selector: "css 선택자"]
context:document
length:0
prevObject:jQuery.fn.init [document, context: document]
selector:"css 선택자"
__proto__:Object(0)
```

`$(".btn")`

```javascript
jQuery.fn.init(3) [a.btn.btn-primary, a.btn.btn-primary, a.btn.btn-primary, prevObject: jQuery.fn.init(1), context: document, selector: ".btn"]
```

`$('button')` : html 태그를 찾아온다 

`$('#title') `:id를 찾아온다.

```javascript
jQuery.fn.init [h1#title, context: document, selector: "#title"]
0:h1#title
context:document
length:1
selector:"#title"
__proto__:Object(0)
```

* 이벤트

1. `$('.btn').이벤트명(이벤트 핸들러)'` : 일괄적용

``` javascript
$('.btn').mouseover(function(){alert("건드리지마...");});
=>jQuery.fn.init(3) [a.btn.btn-primary, a.btn.btn-primary, a.btn.btn-primary, prevObject: jQuery.fn.init(1), context: document, selector: ".btn"]
```

2. `$('.btn').on(이벤트명,이벤트핸들러)`

```javascript
$('.btn').on('mouseover',function(){
    console.log("건드리지마");
});
=>jQuery.fn.init(3) [a.btn.btn-primary, a.btn.btn-primary, a.btn.btn-primary, prevObject: jQuery.fn.init(1), context: document, selector: ".btn"]
```

* jquery multiple events 

```js
$('table.planning_grid').on('mouseenter mouseleave', function() {
    //JS Code
});
```

* mouse가 버튼위에 올라갔을 때, 버튼에 있는 btn-primary클래스를 삭제하고 btn-danger클래스를 준다. 버튼에서 마우스가 내려왔을 때 다시 btn-danger클래스를 삭제하고, btn -primary 클래스를 추가한다. 
* 여러개의 이벤트 등록하기, 요소에 class를 넣고 빼는 jQuery function을 찾아 보자.
* 두 개의 이벤트 리스너, 하나의 이벤트 핸들러 

``` js
var btn = $('.btn')
btn.on('mouseenter mouseout',function(){
    if(btn.hasClass('btn-danger')){
        btn.removeClass('btn-danger').addClass('btn-primary');
    }
    else if(btn.hasClass('btn-primary')){
		btn.removeClass('btn-primary').addClass('btn-danger');
    }
});
```

```js
btn.on('mouseenter mouseout',function(){
   btn.toggleClass('btn-danger').toggleClass('btn-primary');
});
```

$(this) : 이벤트가 발생한 바로 그 자기 자신.

```js
var btn = $('.btn')
undefined
btn.on('mouseenter mouseout',function(){
   $(this).toggleClass('btn-danger').toggleClass('btn-primary'); 	
	console.dir(this);	#html 요소
    console.dir($(this)); #jquery 객체
});
```

* jQuery attr() Method

버튼에 마우스가 오버됐을 때, 상단에 있는 이미지의 속성에 style 속성과 `width: 100px;의 `속성값을 부여한다.

```js
 $('.btn').on('mouseover',function(){
        $('img').attr('style', 'width: 320px;');
  });
```

``` js
$('img').attr('style');
=> "width: 320px;"
```

* jQuery text() Method

```js
$('.btn').on('mouseover',function(){
    $('.card-title').text("Don't Touch Me!!!");
});
```

* 이벤트가 발생한 해당 객체만 변화시키려면? $(this).siblings().find("card-title").text("...")

* jQuery find() Method

* 버튼(요소)에 마우스가 오버(이벤트)됐을 때(이벤트리스너), 이벤트가 발생한 버튼($(this))과 같은 수준에(같은 부모를 가지는) 있는 요소(siblings()) =>

  상위 수준에  있는(parent())

*  중에서 `.card-title`의 속성을 가진 친구를 찾아(find()) 텍스트를 변경(text())시킨다.

***find()는같은 수준이 아니라 하위 요소에서 찾는다. 그래서 siblings()가 아닌 parent()를 써야함***

```js
$('.btn').on('mouseover',function(){
	$(this).parent().find('.card-title').text("건드리지마--");
});
```

### 텍스트 변환기

오타치는 사람 놀리기

*index.html*

```html
<textarea id="input" placeholder="변환할 텍스트를 입력해주세요."></textarea>
<button class="translate">바꿔줘</button>
<h3></h3>
```

* input에 들어있는 텍스트 중에서 '관리' => '고나리', '확인' =>'호가인', '훤하다'=>'허누하다'의 방식으로 텍스트를 오타로 바꾸는 이벤트 핸들러 작성하기.

* https://github.com/e-/Hangul.js 에서 라이브러리를 받아서 자음과 모음을 분리하고, 다시 단어로 합치는 기능 살펴보기

* `String.spilt('')`: ' '안에 있는 것을 기준으로 문자열을 잘라준다(return type :배열)

* `Array.map(function(el))`:배열을 순회하면서 하나의 요소마다 function을 실행시킴.

  (el:순회하는 요소, return type: 새로운 배열)

* `Array.join('')`:배열에 들어있는 내용들을 `''`을 합치는 것.

1. jQuery CDN 불러오기

   ```js
   <head>
     <meta charset="utf-8">
       <title>얼레리 꼴레리</title>
       <script src ="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
     crossorigin="anonymous"></script>
     </head>
   ```

   

2. textarea에 있는 내용물을 가지고 오는 코드

```js
    <script type="text/javascript">
        $('#input').val();			//val()안에 인자가 없을 때는 꺼내오고,
		console.log(input);						 //있을 때는 담아온다.
    </script>
```



1. 버튼에 이벤트 리스너(click)를 달아주고, 핸들러에는 1번에서 작성한 코드를 넣는다.

2. 2번 코드의 결과물을 한글자씩 분해(split)해서 배열로 만들어준다.

3. Hangul.disassemble 

   5-1. 분해한 글자의 4번째 요소가 잇는 지 확인 `

   ```js
   str.split('').map(function(el){
   	var d= Hangul.disassemble(el);
       if(d[3]){}
   });
   ```

   

   5-2. 2번째,3번째 요소가 모음일때  Hangul.isVoewl(c) : 주어진 문자가 모음인지 확인

   ```js
   str.split('').map(function(el){
       var d = Hangul.disassemble(e1);
       if(d[3] && Hangul.isVowel(d[1])&& Hangul.isVowel(d[2])){
           
       }
   })
   ```

   

   5-3. 2번째,3번째 요소를 바꿔준다.

   ```js
   str.split('').map(function(el){
       var d = Hangul.disassemble(e1);
       if(d[3] && Hangul.isVowel(d[1])&& Hangul.isVowel(d[2])){
           var tmp = d[2];
           d[2] = d[3];
           d[3] = tmp;
       }
   })
   ```

   

4. 결과물로 나온 배열을 문자열로 이어준다("join")

   ```js
   str.split('').map(function(el){
       var d = Hangul.disassemble(e1);
       if(d[3] && Hangul.isVowel(d[1])&& Hangul.isVowel(d[2])){
           
       }
   }).join('');
   ```

   

1. 결과물을 출력해줄 요소를 찾는다.

   `index.html`

   ```js
   <!DOCTYPE html>
   <html>
     <head>
     <meta charset="utf-8">
       <title>얼레리 꼴레리</title>
       <script src ="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
     crossorigin="anonymous"></script>
     </head>
     <body>
       <h1>놀리기용 번역기</h1>
       <textarea id="input" placeholder="변환할 텍스트를 입력해주세요."></textarea>
       <button class="translate">바꿔줘</button>
       <h3></h3>
       <script src="./hangul.js" type="text/javascript"></script>
       <script src="./translate.js"></script>
       <script type="text/javascript">
           $('.translate').on('click',function(){
             var input = $('#input').val();
             var result = translate(input);
             $('h3').text(result);
             console.log(result);
           });
       </script>
     </body>
   </html>
   ```

   

2. 요소에 결과물을 출력한다.

   `translate.js`

   ```js
   function translate(str){
       return str.split('').map(function(el){
         var d = Hangul.disassemble(el);
         console.log(d);
         if(d[3] && Hangul.isVowel(d[1])&& Hangul.isVowel(d[2])){
           var tmp   = d[2];
           d[2]      = d[3];
           d[3]      = tmp;
         }
         return Hangul.assemble(d);
   
       }).join('');
   }
   ```

   

   다른 파일에 있는 Function?

   ​	    js

   Client -----> Server

   ​	  <------

   ​	     js 

   서버에 있는 액션은? 자바스크립트로 응답이 올때는, 응답이 올 자바스크립 코드에 넣어준다. 

   어느 메소드(혹은 액션)으로 보낼지.(route)

   자바스크립트코드에서는 어디로 보낼까(url,Http Method)만 알고 있으면 된다.

   ```js
   $.ajax({
       url: 어느 주소로 요청을 보낼지,
       method: 어떤 http method 요청을 보낼지,
       data: {
       	k:v 어떤 값을 함께 보낼지,
       	//서버에서는 params[k] => v
   	}
       
   })
   ```

   ### Ajax  - Watcha에 좋아요 추가

   ``` ruby
   ~/watcha_app (master) $ rails g model likes
   ```

   `db/migrate/create_likes.rb` : join테이블 . m:n관계. 사용자는 여러 영화를 좋아요. 영화는 여러 사람에게 좋아요를 받을 수 있다.

   ```ruby
   class CreateLikes < ActiveRecord::Migration[5.0]
     def change
       create_table :likes do |t|
         t.integer     :user_id
         t.integer     :movie_id
         t.timestamps
       end
     end
   end
   ```

   `models/like.rb`

   ```ruby
   belongs_to :user
   belongs_to :movie
   ```

   `models/movie.rb`

   ```ruby
   has_many	:likes
   has_many 	:users, through: :likes		//movie.likes.count
   ```

   `models/user.rb`

   ```ruby
   class User < ApplicationRecord
     # Include default devise modules. Others available are:
     # :confirmable, :lockable, :timeoutable and :omniauthable
     devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable
     has_many    :likes       
     has_many    :movies, through: :likes
   end
   ```

   `views/movies/show.html.erb`

   ```erb
   <h1><%= @movie.title %></h1>
   <hr>
   <p><%= @movie.description %></p>
   
   <%= link_to 'Edit', edit_movie_path(@movie) %> |
   <%= link_to 'Back', movies_path %>
   <hr>
   <button class="btn btn-info like">좋아요</button>
   
   <script>
   $(document).on('ready',function(){
     $('.like').on('click',function(){
       console.log("like!!!");
       $.ajax({
          url: '/likes/<%= @movie.id %>' 
       });
     });
   }); 
   </script>
   ```

   1. `좋아요`버튼을 눌렀을 때
   2. 서버에 요청을 보낸다. (현재 유저가 현재 보고있는 이 영화가 좋다고 하는 요청 )
   3. 서버가 할 일
   4. 응답이 오면 `좋아요` 버튼의 텍스트를 `좋아요`취소로 바꾸고, `btn-info` ->`btn-warnin g text-white  `로 바꿔준다.

   

   `config/routes.rb`

   ```ruby
   get '/likes/:movie_id'	=> 'movies#like_movie'
   ```

   `controller/movies_controller.rb`

   ```ruby
     def like_movie
       p params
       #현재 유저와 params에 담긴 movie 간의
       #좋아요 관계를 설정한다.
       Like.create(user_id: current_user.id,movie_id: params[:movie_id])
     end
   ```

   `movies/like_movie.js.erb`

   ```erb
   alert("좋아요가 설정되었습니다.");
   ```

   * 로그인이 안 됐을 경우, `좋아요`버튼을 누를 수 없음 -> 로그인 페이지로 이동

   `movie_controller.rb`

   ```erb
   before_action :js_authenticate_user!, only: [:like_movie]
   ```

   `application_controller.rb`

   ```ruby
   class ApplicationController < ActionController::Base
     protect_from_forgery with: :exception
     def js_authenticate_user!
       render js: "alert('로그인이 필요합니다');" unless user_signed_in?
     end
     
   end
   ```

   

* `좋아요` 취소

`like_movie.js.erb`

```erb
alert("좋아요가 설정되었습니다.");
$('.btn').text("좋아요 취소");
```

* frozen

```ruby
    @like.frozen?  #true : 삭제된 경우,false : 새로 만들어진 경우
```

