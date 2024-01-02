<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.temporal.ChronoUnit"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Product Detail</title>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" href="./css/detail.css">
<link rel="stylesheet" href="./css/navbar.css">
</head>
<body>
	<c:forEach var="dl" items="${detail_result }">
		<c:set var="member_goods_link"
			value="${sessionScope.member_no == null ? 'login_form' : 'member_goods'}" />
		<c:set var="chat_link"
			value="${sessionScope.member_no == null ? 'login_form' : 'chat?goods_no=${dl.goods_no}&member_no=${dl.member_no }&session_member_no=${session_member_no }'}" />
		<!-- header -->
		<%@ include file="/WEB-INF/views/include/navbar.jsp"%>

		<div
			class="d-flex flex-column justify-content-center mx-auto px-3 my-5 py-5"
			id="detail">

			<div class="container" id="detail_goods">
				<div class="row">
					<!-- 상품 이미지 carousel -->

					<div id="carouselIndicators" class="carousel slide col-5">
						<div class="carousel-indicators">
							<button type="button" data-bs-target="#carouselIndicators"
								data-bs-slide-to="0" class="active" aria-current="true"
								aria-label="Slide 1"></button>
							<button type="button" data-bs-target="#carouselIndicators"
								data-bs-slide-to="1" aria-label="Slide 2"></button>
							<button type="button" data-bs-target="#carouselIndicators"
								data-bs-slide-to="2" aria-label="Slide 3"></button>
						</div>

						<div class="carousel-inner">
							<div class="carousel-item active">
								<img id="goods_image" src="${dl.goods_image }"
									class="d-block w-100" alt="상품 이미지1"
									onerror="this.src='https://via.placeholder.com/600x600'">
							</div>
							<div class="carousel-item">
								<img id="goods_image" src="${dl.goods_image }"
									class="d-block w-100" alt="상품 이미지2"
									onerror="this.src='https://via.placeholder.com/600x600'">
							</div>
							<div class="carousel-item">
								<img id="goods_image" src="${dl.goods_image }"
									class="d-block w-100" alt="상품 이미지3"
									onerror="this.src='https://via.placeholder.com/600x600'">
							</div>
						</div>

						<button class="carousel-control-prev" type="button"
							data-bs-target="#carouselIndicators" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#carouselIndicators" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>

					<!-- 상품명, 가격 등등 -->
					<div class="col-7">
						<div class="row">
							<div class="col-9">
								<h3 class="mb-3" id="goods_name">${dl.goods_name }&nbsp;

									<!-- 하트 클릭 -->
									<input type="hidden" name="liked_state" value="${heart_result}">
									<i id="heart_icon" class="far fa-heart"></i>



								</h3>
							</div>
							<div class="col-3">
								<c:if test="${dl.member_no == session_member_no }">
									<div class="btn-group btn-group-sm" role="group"
										aria-label="Small button group" id="edit">
										<button type="button" class="btn btn-outline-primary" onclick="location.href='update_sell_form?goods_no=${dl.goods_no}'">수정</button>
										<button type="button" class="btn btn-outline-danger"
											data-bs-toggle="modal" data-bs-target="#staticBackdrop">삭제</button>
									</div>
								</c:if>

								<!-- 삭제 확인 모달창 -->
								<div class="modal fade" id="staticBackdrop"
									data-bs-backdrop="static" data-bs-keyboard="false"
									tabindex="-1" aria-labelledby="staticBackdropLabel"
									aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h1 class="modal-title fs-5" id="staticBackdropLabel">상품
													삭제</h1>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">${dl.goods_name }을 삭제하시겠습니까?</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">닫기</button>
												<button type="button" class="btn btn-danger"
													onclick="location.href='detail_delete?goods_no=${dl.goods_no}'">삭제</button>
											</div>
										</div>
									</div>
								</div>

								<script>
								const myModal = document.getElementById('myModal') const myInput
								= document.getElementById('myInput')

								myModal.addEventListener('shown.bs.modal', () => {
								myInput.focus() })
								</script>

							</div>
						</div>
						<div class="row">
							<div class="col-7">
								<h5>${dl.goods_price }원&nbsp;
									<a href="lowest_baechu?compare_product=${dl.goods_name }"
										id="recent_price">최근 가격 확인하기</a>
								</h5>
							</div>
							<div class="col-5" id="time_div">
								<!-- 시간 변환 출력 -->
								<c:if test="${minute <= 60}">
									<p class="text-muted" id="detail_indicator">&nbsp;${minute }분&nbsp;전</p>
								</c:if>
								<c:if test="${minute > 60 && minute <= 1440}">
									<p class="text-muted" id="detail_indicator">
										<!-- &nbsp; -->${Math.round(minute / 60) }시간&nbsp;전</p>
								</c:if>
								<c:if test="${minute > 1440 && minute <= 10080}">
									<p class="text-muted" id="detail_indicator">&nbsp;${Math.round(minute / 1440) }일&nbsp;전</p>
								</c:if>
								<c:if test="${minute > 10080}">
									<p class="text-muted" id="detail_indicator">&nbsp;${dl.goods_regdate }</p>
								</c:if>
							</div>

							<!-- 수평선1 -->
							<hr>

						</div>

						<!-- 조회수, 관심, 내용 -->
						<div class="row">
							<div class="col-8">
								<a href="<c:url value='${member_goods_link}'/>" id="member_nick"><i
									class="fa-regular fa-user" id="user_img"></i></a>

								<!-- 카카오톡 공유하기 -->
								<a id="kakaotalk-sharing-btn" href="javascript:;"> <i
									class="fa-solid fa-share" id="kakaotalk-sharing-img"></i></a>
							</div>
							<div class="col-4" id="view_div">
								<p>조회&nbsp;${dl.goods_readcount }&nbsp;·&nbsp;관심&nbsp;${heart_count }</p>
							</div>
						</div>

						<div class="row">
							<div>
								<textarea id="goods_content" readonly>${dl.goods_content }</textarea>
							</div>
						</div>

						<!-- 희망거래장소 -->
						<div class="row">
							<div class="col-10" id="trade_here">
								<i class="fa-solid fa-location-dot" id="trade_marker"></i>&nbsp;<span>여기서
									거래해요!</span>
								<div id="map"></div>
							</div>
							<div class="col-2 text-end">
								<button class="btn btn-outline-dark mt-2" id="chat"
									onclick="location.href='<c:url value='${chat_link}'/>'">채팅하기</button>
							</div>
						</div>

					</div>
				</div>

				<!-- 수평선2 -->
				<hr>

			</div>
		</div>
		<!-- detail_store_container end -->

		<!-- 인기상품 목록 -->
		<div class="container" id="detail_hit">
			<div class="row mx-auto">
				<h5 id="hit_goods">인기상품 보고가세요!</h5>
				<c:forEach var="best" items="${best_detail }">
					<div class="col-2 mx-auto" id="hit_image">
						<a href="detail?goods_no=${best.goods_no }" id="hit_name"> <img
							alt="인기상품" src=""
							onerror="this.src='https://via.placeholder.com/200x200'">
							<p>${best.goods_name }</p></a>
						<p>${best.goods_price}원</p>
					</div>
				</c:forEach>
			</div>
		</div>
		<!-- detail_container end -->

		<%@ include file="/WEB-INF/views/include/footer.jsp"%>

		<!-- 하트 -->
		<script>
		document.addEventListener('DOMContentLoaded', function() {
	    var heart_icon = document.getElementById('heart_icon');
	    var heart_value = document.querySelector('input[name="liked_state"]');
	    
	    if (heart_value.value == '1') {
	    	heart_icon.classList.add('fas', 'text-danger');
	    } else {
	    	heart_icon.classList.add('far');
	    }

	    heart_icon.addEventListener('click', function() {
	        var session_member_no = "<c:out value='${sessionScope.member_no}'/>";	
	        if (!session_member_no || session_member_no === "null" || session_member_no === "undefined") {
	        	
	            alert("로그인 후 이용해주세요.");
	        } else {
	        	// 클래스를 모두 제거
	            heart_icon.classList.remove('far', 'fas', 'text-danger');
	            
	            if (heart_value.value == '1') {
	            	heart_value.value = '0'; 
	                heart_icon.classList.add('far');
	            } else {
	            	heart_value.value = '1'; 
	                heart_icon.classList.add('fas', 'text-danger');
	            }
	        
	            // 서버에 하트 클릭 이벤트를 전달하는 Ajax 요청
	            $.ajax({
	                type: "GET",
	                url: "heart_click",
	                data: { 'goods_no': '<c:out value="${dl.goods_no}" />', 'liked_state': heart_value.value },
	                success: function(response) {
	                }
	            });
	        }
	    });
	});
	</script>

		<!-- 카카오맵 api -->
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=977ee17ba59e7721767fe0fdf92b13a5&libraries=services"></script>

		<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.499593, 127.030474), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('${dl.goods_place}', function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	        
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
            	content : '<div id="place_info">${dl.goods_place}</div>'
       		 });
	        infowindow.open(map, marker);

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	   		 } 
			});    
			</script>

		<!-- 카카오톡 공유하기 -->
		<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.6.0/kakao.min.js"></script>
		<script> Kakao.init('977ee17ba59e7721767fe0fdf92b13a5'); </script>

		<script>
  		Kakao.Share.createDefaultButton({
  		container: '#kakaotalk-sharing-btn',
   		objectType: 'commerce',
    	content: {
      	title: '가장 가까운 플리마켓, 양배추마켓',
      	imageUrl:
        'https://ifh.cc/g/MLlxfz.png',
      	link: {
        webUrl: 'http://localhost/market/detail?goods_no=${dl.goods_no}',
      	},
    	},
    	commerce: {
      	productName: '${dl.goods_name}',
      	regularPrice: ${dl.goods_price},
    	},
    	buttons: [
      	{
        title: '구매하기',
        link: {
          webUrl: 'http://localhost/market/detail?goods_no=${dl.goods_no}',
        },
      	},
      	{
        title: '공유하기',
        link: {
         webUrl: 'http://localhost/market/detail?goods_no=${dl.goods_no}',
        },
      	},
    	],
  		});
	</script>

	</c:forEach>
</body>
</html>
