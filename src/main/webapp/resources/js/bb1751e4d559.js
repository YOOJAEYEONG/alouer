$(document).ready(function() {
    new Clipboard('.artworkDetail-codeCopyBtn');
    $('.artworkDetail-codeCopyBtn').click(function() {
        $(this).attr('data-clipboard-text', $(this).data('code'));
    });
    new Clipboard('.copy_reco_comment_btn');
    $('.copy_reco_comment_btn').click(function() {
        var content = $(this).data('content');
        content = $(this).data('artist_name') + ' 작가 / ' + $(this).data('size_number') + '\n\n' + content;
        content = content + '\n\n' + 'https://www.opengallery.co.kr/artwork/' + $(this).data('code') + '/';
        $(this).attr('data-clipboard-text', content);
        alert('[추천사 클립보드 복사 완료]\n\n' + content);
    });
    $('#show_more_info').click(function() {
        var $fold_btn = $(this);
        if ($fold_btn.hasClass('folded')) {
            $fold_btn.removeClass('folded');
            $fold_btn.text('접기');
            $('.more_info').show();
        } else {
            $fold_btn.addClass('folded');
            $fold_btn.text('더보기');
            $('.more_info').hide();
        }
    });
    $('#add_into_pfr_btn').change(function() {
        var pfr_id = $(this).find('option:selected').val()
          , artwork_code = $(this).data('artwork_code');
        $(this).val('');
        if (confirm('선택하신 \'오늘의 추천 작품\'에 이 작품을 추가하시겠습니까?')) {
            $.ajax({
                url: '/luna/api/add_into/plus_friend_reco/',
                type: 'POST',
                data: {
                    plus_friend_reco_id: pfr_id,
                    artwork_code: artwork_code
                },
                async: false,
                dataType: 'json',
                success: function(responseJson) {
                    if (responseJson.success) {
                        alert('작품 추가 완료');
                    } else {
                        alert(responseJson.reason);
                    }
                },
                error: function() {
                    alert('서버 통신 오류');
                }
            });
        }
    });
});
$(document).ready(function() {
    var $artwork_detail = $('.artworkDetail')
     /* , $event_footer = $('.event_footer')*/
      , $rental_mask = $('.rental_mask');
    opg.fn.detailView_init($artwork_detail, dj_context.artwork_code, dj_context.is_over_100);
    opg.fn.warehousingNoti($artwork_detail, dj_context.artwork_code);
/*    if ($event_footer.length) {
        dataLayer.push({
            'event': 'event_landing',
            'eventLabel': 'quick1st90days_showFooter'
        });
        $event_footer.addClass('show');
    }*/
    if (location.hash.startsWith('#zoom')) {
        if (history.pushState) {
            history.replaceState(null, null, location.search);
        } else {
            location.hash = '';
        }
    }
    $(window).on('hashchange', function() {
        var hash = location.hash, zoom_number, $zoom_image;
        if (hash.startsWith('#zoom')) {
            zoom_number = hash.substring(5);
            if (zoom_number === '') {
                zoom_number = '0';
            }
            $zoom_image = $('.artworkDetail-imageViewer-img:eq(' + zoom_number + ')');
            if ($zoom_image.length) {
                opg.fn.panzoomPopup($zoom_image.data('image_url'));
                return;
            }
        }
        opg.fn.destroy_popup_2();
    });
    $('.artworkDetail-customerReview-unfoldBtn').click(function() {
        $(this).parent().removeClass('folded');
    });
    var noti180921_value = parseInt(getCookie('noti180921'));
    if (!noti180921_value) {
        opg.fn.setCookie('noti180921', '1', 30);
    } else if (noti180921_value < 3) {
        opg.fn.setCookie('noti180921', noti180921_value + 1, 30);
    }
    if ($('#noticeBox-bgMask').length > 0) {
        $('#noticeBox').show();
    }
    $('#rental_os_open_btn').on('click', function() {
        var scrollbarWidth = getScrollbarW();
        $rental_mask.addClass('active');
        $body.css({
            overflowY: 'hidden',
            marginRight: scrollbarWidth
        });
        setFixedPosition(scrollbarWidth);
    });
    $('#rental_os_close_btn, .rental_os_layer_mask').on('click', function() {
        $rental_mask.removeClass('active');
        $body.css({
            overflowY: 'visible',
            marginRight: 0
        });
        setFixedPosition(0);
    });
});