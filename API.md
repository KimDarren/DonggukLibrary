# 동국대학교 중앙도서관 열람실 좌석 현황 API
_There is no English version. If you cannot read Korean, you should go back :) sorry._

## 소개
### 뭐 하는 API죠?
* [동국대학교 중앙도서관](http://map.naver.com/local/siteview.nhn?code=11592555) 내의 열람실 좌석 정보를 실시간으로 제공합니다.

### 데이터는 어디서 가져오나요?
* [동국대학교 중앙도서관 열람실 좌석 현황](http://210.94.200.151/EZ5500/SEAT/RoomStatus.aspx) 웹사이트를 겁나 빠르게 파싱해옵니다.

## 사용해보기 전에
* 이 API는 PHP로 작성되었습니다.
	* *다시는 PHP를 무시하지 마라 - [Mark Zuckerberg](https://en.wikipedia.org/wiki/Mark_Zuckerberg)*
* [제](http://koreandarren.com) 집에 있는 [Mac mini](http://www.apple.com/shop/buy-mac/mac-mini) 서버에 얹어진 API 입니다.
	* 과도한 API 호출은 맥미니를 아프게 합니다.
* [JSON](http://json.org/json-ko.html)
	* 모든 데이터 통신은 JSON으로 합니다. 그게 옳기 때문에 그게 옳습니다.
* *`API_KEY`* 같은거 없습니다. 하지만 API 사용할 때 [알려주셈](mailto:koreandarren@gmail.com)

## 사용해보기
*여러분!! [HURL.IT](https://www.hurl.it) 사용해서 천국 갑시다!!!*

### API 주소
* http://api.koreandarren.com/dongguk_library

### 열람실 목록 및 요약 정보 가져오기
* `/room_list.php`
* 파라미터값은 없습니다.
* RESPONSE

```json
[
    {
    	"title":"4층 제1열람실A",
    	"total_count":"244",
    	"using_count":"0",
    	"remain_count":"244",
    	"rate":"0%",
    	"number":1
    }, ...
]
```

* 결과값 분석
	* ***title***	: 열람실 이름
	* ***total-count***: 전체 좌석 수
	* ***using_count***: 사용중인 좌석 수
	* ***remain_count***: 남은 좌석 수
	* ***rate***: 사용 비율
	* ***number***: 열람실 고유 번호 _(추후에 필요하니 기억해두자!)_

### 열람실별 좌석 현황 가져오기
* `/room_status.php`
* 파라미터값
	* number	( ***INTEGER*** ) : 위의 열람실 정보에서 받아온 number 값
* RESPONSE

```json
{
	"enable": ["245","274","275","302","303","332","333", ... ],
	"disable":["349","259", ... ],
	"using":["260","289", ... ]
}
```

* 결과값 분석
	* ***enable***: 사용 가능한 좌석 번호들
	* ***using***: 사용중인 좌석 번호들
	* ***disable***: 사용 불가능한 좌석 번호들

### 이게 끝인가요?
* 네.
* 열람실별 좌석 목록 및 배치도는 [공식 홈페이지]((http://210.94.200.151/EZ5500/SEAT/RoomStatus.aspx))에서 눈으로 확인하세요.
