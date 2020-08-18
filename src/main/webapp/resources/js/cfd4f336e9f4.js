function getCookie(name) {
    var cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        var cookies = document.cookie.split(';');
        for (var i = 0; i < cookies.length; i++) {
            var cookie = jQuery.trim(cookies[i]);
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}
var csrftoken = getCookie('csrftoken');
function csrfSafeMethod(method) {
    return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
}
$.ajaxSetup({
    beforeSend: function(xhr, settings) {
        if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
            xhr.setRequestHeader("X-CSRFToken", getCookie('csrftoken'));
        }
    }
});
function post(path, params, method, target) {
    method = method || 'post';
    params = params || {};
    params['csrfmiddlewaretoken'] = getCookie('csrftoken');
    target = target || '';
    var form, hiddenField, key, name, value, i;
    form = document.createElement('form');
    form.setAttribute('method', method);
    form.setAttribute('action', path);
    form.target = target;
    for (key in params) {
        if (params.hasOwnProperty(key)) {
            name = key;
            value = params[key];
            if (Object.prototype.toString.call(value) === '[object Array]') {
                for (i = 0; i < value.length; i += 1) {
                    hiddenField = document.createElement('input');
                    hiddenField.setAttribute('type', 'hidden');
                    hiddenField.setAttribute('name', name);
                    hiddenField.setAttribute('value', value[i]);
                    form.appendChild(hiddenField);
                }
            } else {
                hiddenField = document.createElement('input');
                hiddenField.setAttribute('type', 'hidden');
                hiddenField.setAttribute('name', name);
                hiddenField.setAttribute('value', value);
                form.appendChild(hiddenField);
            }
        }
    }
    document.body.appendChild(form);
    form.submit();
    document.body.removeChild(form);
}
$(document).ready(function() {
    var $window = $(window)
      , $body = $('body')
      , $header = $('#header')
      , $user_setting_btn = $('#userBox-settingBtn')
      , $user_menu_box = $('#userBox-settingBox')
      , $mobile_nav = $('#mobile_nav')
      , $header_nav = $('#header-nav')
      , $header_sub_menu = $('#header-sub-menu')
      , $recently_viewed_artwork_count = $('#mSide-recentlyCnt')
      , lastScrollTop = 0
      , $header_banner = $('#header_banner')
      , $wrap_padding = $('.header_banner_padding');
    function destroy_user_menu_box() {
        $user_menu_box.fadeOut(100, function() {
            $body.unbind('.user_menu');
            $user_setting_btn.removeClass('active');
        });
    }
    function search_focus() {
        if ($header.hasClass('search_active')) {
            $('#header-searchBar-sq').focus();
        } else {
            $('#header-searchBar-sq').blur();
        }
    }
    $header_nav.hover(function() {
        $('#header-sub-menu').show();
        $header.addClass('active_submenu');
    }, function() {
        $('#header-sub-menu').hide();
        $header.removeClass('active_submenu');
    });
    $header_sub_menu.hover(function() {
        $('#header-sub-menu').show();
        $header.addClass('active_submenu');
    }, function() {
        $('#header-sub-menu').hide();
        $header.removeClass('active_submenu');
    });
    var $header_top_height;
    if ($wrap_padding.length > 0) {
        $header_top_height = $header.outerHeight() + $('#header_banner').outerHeight();
    } else {
        $header_top_height = $header.outerHeight();
    }
    $window.on('scroll.headerHiding', function(e) {
        var scrollY = window.scrollY || $window.scrollTop()
          , delta = scrollY - lastScrollTop;
        if (Math.abs(delta) <= 5) {
            return;
        }
        if ($(window).scrollTop() + $(window).height() < $(document).height() - 300 && delta > 0 && scrollY > $header_top_height) {
            if ($user_menu_box.is(':visible')) {
                $user_menu_box.hide();
                $body.unbind('.user_menu');
                $user_setting_btn.removeClass('active');
            }
            $header.removeClass('search_active').addClass('headerHiding');
            $mobile_nav.addClass('nav_fixed');
            $header.addClass('active_submenu');
            $header_banner.addClass('headerbannerHiding');
            $wrap_padding.addClass('wrap_padding');
            $('#header-searchBar-sq').blur();
        } else {
            $header.removeClass('headerHiding');
            $mobile_nav.removeClass('nav_fixed');
            $header.removeClass('active_submenu');
            $header_banner.removeClass('headerbannerHiding');
            $wrap_padding.removeClass('wrap_padding');
            $('#header-sub-menu').hide();
        }
        lastScrollTop = scrollY;
    });
    var mobile_nav_mask = $('.mobile_nav_mask')
      , none_sub = $('.nav-arrow.none_sub');
    function mobile_nav_check() {
        if ($('.m1').hasClass('active') || $('.m2').hasClass('active')) {
            mobile_nav_mask.addClass('active');
        } else {
            mobile_nav_mask.removeClass('active');
        }
    }
    function none_sub_check() {
        if ($('.m2').hasClass('none_sub')) {
            if ($('.m1').data('origin') === $('.m1').text()) {
                $('.m1').css('font-weight', 'bold');
            } else {
                $('.m1').css('font-weight', 'normal');
            }
        }
    }
    $('.m1').on('click', function() {
        var $tab2 = $('.m2');
        var select_value = $(this).attr('rel')
          , origin_value = $(this).data('origin')
          , origin_value2 = $tab2.data('origin');
        if ($(this).hasClass('active')) {
            $('.mobile-nav-sub-select').removeClass('active');
            $("#" + select_value).addClass('active');
            $('.mobile-nav-dropdown').removeClass('active');
            $(this).removeClass('active');
            mobile_nav_check();
        } else {
            $('.mobile-nav-sub-select').removeClass('active');
            $("#" + select_value).addClass('active');
            $('.mobile-nav-dropdown').addClass('active');
            $(this).addClass('active');
            $tab2.removeClass('active');
            none_sub.removeClass('active');
            $(this).text(origin_value);
            $tab2.text(origin_value2);
            mobile_nav_check();
            none_sub_check();
        }
    });
    $('.m2').on('click', function() {
        var $tab1 = $('.m1');
        var select_value = $(this).attr('rel')
          , origin_value = $(this).data('origin')
          , origin_value1 = $tab1.data('origin');
        if ($(this).hasClass('active')) {
            $('.mobile-nav-sub-select').removeClass('active');
            $("#" + select_value).addClass('active');
            $('.mobile-nav-dropdown').removeClass('active');
            $(this).removeClass('active');
            none_sub.removeClass('active');
            $(this).html('<strong>' + origin_value + '</strong>');
            $tab1.text(origin_value1);
            mobile_nav_check();
            none_sub_check();
        } else {
            $('.mobile-nav-sub-select').removeClass('active');
            $("#" + select_value).addClass('active');
            $('.mobile-nav-dropdown').addClass('active');
            $(this).addClass('active');
            none_sub.addClass('active');
            $('.m1').removeClass('active');
            mobile_nav_check();
        }
    });
    $('.mobile-nav-main-menu.submenu').on('click', function() {
        var $tab1 = $('.m1');
        $tab2 = $('.m2');
        var select_value = $(this).attr('rel');
        if ($tab1.hasClass('active')) {
            $tab1.removeClass('active');
            $tab2.addClass('active');
            none_sub.addClass('active');
            $('.mobile-nav-sub-select').removeClass('active');
            $("#" + select_value).addClass('active');
            $(this).addClass('active').siblings().removeClass('active');
            $tab1.text($(this).text());
            $tab2.text('선택');
            none_sub_check();
        } else {
            $tab2.addClass('active');
            none_sub.addClass('active');
            $('.mobile-nav-sub-select').removeClass('active');
            $("#" + select_value).addClass('active');
            $(this).addClass('active').siblings().removeClass('active');
        }
    });
    mobile_nav_mask.on('click', function() {
        var $tab1 = $('.m1');
        var $tab2 = $('.m2');
        var origin_value1 = $tab1.data('origin')
          , origin_value2 = $tab2.data('origin')
          , $mobile_nav_dropdown = $('.mobile-nav-dropdown');
        $(this).removeClass('active');
        $tab1.removeClass('active').text(origin_value1);
        $tab2.removeClass('active').html('<strong>' + origin_value2 + '</strong>');
        $('.mobile-nav-sub-select').removeClass('active');
        $mobile_nav_dropdown.removeClass('active');
    });
    $user_menu_box.click(function(e) {
        e.stopPropagation();
    });
    $user_setting_btn.click(function(e) {
        if ($user_menu_box.is(':visible')) {
            destroy_user_menu_box();
        } else {
            $user_menu_box.fadeIn(100, function() {
                $body.one('click.user_menu', destroy_user_menu_box);
                $user_setting_btn.addClass('active');
            });
        }
        e.preventDefault();
    });
    $('#header-cart-btn, #header-mycollection-btn').click(function(e) {
        if (!$('#userBox').hasClass('logged_in')) {
            alert('카트 / 마이컬렉션 메뉴는 로그인 후에 이용할 수 있습니다.');
            opg.fn.loginPopup();
            e.preventDefault();
        }
    });
    $('#mSide-cartBtn, #mSide-mycollectionBtn').click(function(e) {
        if (!$('#userBox').hasClass('logged_in')) {
            alert('카트 / 마이컬렉션 메뉴는 로그인 후에 이용할 수 있습니다.');
            opg.fn.hide_mBar(opg.fn.loginPopup);
            e.preventDefault();
        }
    });
    $('#mSide-menuBar').click(function(e) {
        e.stopPropagation();
        $('#header-searchBar-sq').blur();
    });
    $('#mHeaderBtn_showMenu').click(function() {
        $header.removeClass('search_active');
        opg.fn.show_mMenuBar();
        $('#header-searchBar-sq').blur();
    });
    $('#mHeaderBtn_hideMenu').click(function() {
        opg.fn.hide_mBar();
        $('#header-searchBar-sq').blur();
    });
    $('.mSide-showNavSubBtn').click(function() {
        var $this = $(this)
          , $navSub = $this.parent().find('.mSide-navSub')
          , $navBtn = $this.find('.mSide-navBack');
        if ($navBtn.hasClass('subMode') === true) {
            $navBtn.removeClass('subMode');
            $navSub.removeClass('show');
        } else {
            $navBtn.addClass('subMode');
            $navSub.addClass('show');
        }
    });
    $('#header-showSearch-btn').click(function() {
        $header.toggleClass('search_active');
        search_focus();
    });
    $('#header-searchMask').click(function() {
        $header.removeClass('search_active');
        $('#header-searchBar-sq').blur();
    });
    var $header_notice_button = $('#header-notice-btn')
      , $notice_box = $('#noticeBox')
      , $notice_close_btn = $notice_box.find('#noticeBox-closeBtn');
    $header_notice_button.click(function() {
        $header.removeClass('search_active');
        $notice_box.show();
    });
    $notice_close_btn.click(function() {
        $notice_box.hide();
        $header_notice_button.addClass('seen');
        $('#noticeBox-bgMask').hide();
    });
    $('#header_banner_close').click(function() {
        opg.fn.setCookie('header_banner', "done", 1);
        $('#header_banner').hide();
        $('#header').removeClass('use_banner');
        $('#wrap').removeClass('header_banner_padding');
    });
    $('#header-searchBar-form').submit(function() {
        var $form = $(this)
          , search_keyword = $form.find('[name=sq]').val();
        dataLayer.push({
            event: 'search_action',
            eventLabel: 'header_to_search_submit',
            search_keyword: search_keyword
        });
    });
    $('#footer-awards-inner').owlCarousel({
        responsive: {
            0: {
                items: 4
            },
            767: {
                items: 5
            },
            991: {
                items: 6
            }
        },
        dots: false,
        nav: false,
        loop: true,
        margin: 10,
        autoplay: true,
        autoplayTimeout: 2000,
        autoplayHoverPause: true
    });
    $('#footer-subscription-form').submit(function(e) {
        var form = $(this)
          , formAction = form.attr("action")
          , formData = form.serializeArray();
        if (!form.hasClass('disabled')) {
            $.ajax({
                type: "POST",
                url: formAction,
                data: formData,
                dataType: 'json',
                success: function(jsonResponse) {
                    if (jsonResponse.success) {
                        /*fbq('trackCustom', 'NewsletterSubscription');*/
                        dataLayer.push({
                            'event': 'subscription_submit'
                        });
                        alert('신청해주셔서 감사합니다. 이메일이 잘 오지 않는 경우 스팸함을 확인해주시거나, 정확한 이메일주소로 다시 신청해주세요.');
                        form.removeClass('disabled');
                    } else {
                        switch (jsonResponse.reason) {
                        case 'email_validation_error':
                            alert('잘못된 이메일 주소 입니다. 유효한 이메일 주소를 입력해주세요.');
                            break;
                        case 'already_added':
                            alert('등록된 이메일 입니다. 로그인하여 정보를 수정해주세요.');
                            break;
                        default:
                            alert('죄송합니다. 새로고침 후 다시 시도해주세요.');
                        }
                        form.removeClass('disabled');
                    }
                    form.find('[name="email"]').val('');
                },
                error: function() {
                    alert('죄송합니다. 새로고침 후 다시 시도해주세요.');
                    form.removeClass('disabled');
                }
            });
            form.addClass('disabled');
        }
        e.preventDefault();
    });
    if (device_type === 2) {
        $('#wrap').append('<div id="basePage-back" onclick="window.history.back();"></div>');
    }
    var recently_viewed_artworks = '';
    try {
        recently_viewed_artworks = atob(opg.fn.getCookie('recently_viewed_artworks').replace(/"/gi, ''));
    } catch (e) {
        recently_viewed_artworks = '';
    }
    var $basePageUp = $('#basePage-up')
      , $recentlyViewedArtworkBtn = $('#basePage-RecentlyViewedArtworks')
      , $recentlyViewedArtwork_popup = $('#recentlyViewedArtworks-popup')
      , $kakaoPlusBtn = $('#kakaoPlusBtn')
      , user_agent = navigator.userAgent
      , artwork_list = recently_viewed_artworks.split(',').filter(function(n) {
        return n !== ""
    })
      , last_artwork_code = ''
      , last_artist_code = ''
      , $thumbRecent = $('<img src=""/>')
      , artwork_regex = /A[0-9]{4}-[0-9]{4}/
      , artist_regex = /A[0-9]{4}/;
    if (recently_viewed_artworks === '') {
        $recently_viewed_artwork_count.text(0);
    } else {
        $recently_viewed_artwork_count.text(artwork_list.length);
    }
    $basePageUp.click(function() {
        window.scrollTo(0, 0);
    });
    if (recently_viewed_artworks !== '') {
        last_artwork_code = artwork_list[artwork_list.length - 1];
        last_artist_code = last_artwork_code.split('-')[0];
    }
    if (!(artwork_regex.test(last_artwork_code) && artist_regex.test(last_artist_code))) {
        $thumbRecent.hide();
        $window.scroll(function() {
            var scrollY = window.scrollY || $window.scrollTop();
            if (scrollY > 0) {
                $basePageUp.addClass('show');
                $kakaoPlusBtn.addClass('high');
            } else {
                $basePageUp.removeClass('show');
                $kakaoPlusBtn.removeClass('high');
            }
        });
    } else {
        var thumb_url = 'https://og-data.s3.amazonaws.com/media/artworks/small_thumb/' + last_artist_code + '/' + last_artwork_code + '.jpg';
        $thumbRecent.prop('src', thumb_url);
        $recentlyViewedArtworkBtn.append($thumbRecent);
        $recentlyViewedArtworkBtn.addClass('show');
        $kakaoPlusBtn.addClass('row');
        $window.scroll(function() {
            var scrollY = window.scrollY || $window.scrollTop();
            if (scrollY > 0) {
                $basePageUp.addClass('show');
                $recentlyViewedArtworkBtn.addClass('high');
                $recentlyViewedArtwork_popup.addClass('high');
                $kakaoPlusBtn.addClass('high');
            } else {
                $basePageUp.removeClass('show');
                $recentlyViewedArtworkBtn.removeClass('high');
                $recentlyViewedArtwork_popup.removeClass('high');
                $kakaoPlusBtn.removeClass('high');
            }
        });
    }
    $window.scroll();
    $recentlyViewedArtworkBtn.click(function() {
        var origin_overflow_x = $body.css('overflow-x'), origin_overflow_y = $body.css('overflow-y'), popup_wrapper, overlay = $('<div class="overlay all"></div>'), scrollbarWidth = getScrollbarW(), url = '/recently/artworks/';
        function destroy_popup() {
            if (overlay.hasClass('hidden')) {
                return;
            }
            popup_wrapper.fadeOut(0, function() {
                $(this).remove();
            });
            $body.css({
                overflowX: origin_overflow_x,
                overflowY: origin_overflow_y,
                marginRight: 0
            });
            setFixedPosition(0);
            $window.scroll();
            $document.unbind('.popup');
        }
        popup_wrapper = $('#popup_wrapper');
        if (popup_wrapper.length === 0) {
            popup_wrapper = $('<div id="popup_wrapper"></div>');
            popup_wrapper.hide().appendTo('#wrap').fadeIn(0, function() {
                $body.css({
                    overflowY: 'hidden',
                    marginRight: scrollbarWidth
                });
                setFixedPosition(scrollbarWidth);
                $document.bind('keydown.popup', function(e) {
                    if (e.keyCode === 27) {
                        destroy_popup();
                    }
                });
            });
            popup_wrapper.data({
                body_overflow_x: origin_overflow_x,
                body_overflow_y: origin_overflow_y
            });
        } else {
            origin_overflow_x = popup_wrapper.data('body_overflow_x');
            origin_overflow_y = popup_wrapper.data('body_overflow_y');
            popup_wrapper.empty();
        }
        overlay.click(function() {
            destroy_popup();
        }).css({
            opacity: 0
        }).animate({
            opacity: 1
        }).append($('<div id="recentlyPopup-content"></div>')).appendTo(popup_wrapper);
        $.ajax({
            type: 'GET',
            url: url,
            dataType: 'json',
            success: function(jsonResponse) {
                if (jsonResponse.success) {
                    var popupContent = $('#recentlyPopup-content')
                      , $popupHeader = $('<div class="recentlyPopup-header">최근 본 작품</div>')
                      , $popupBody = $('<div class="recentlyPopup-body">' + '<div class="recentlyPopup-bodyHeader cf">' + '<span class="recentlyPopup-artworkCount">총 <span class="recentlyPopup-artworkCount count">' + jsonResponse.artwork_count + '</span>점</span>' + '<a href="/recently/artworks/" class="more_loading" onclick="ga_clk_recentlyview(\'layer_recently_more\');">전체보기</a>' + '</div>' + '</div>')
                      , $artworkList = $('<div class="recentlyPopup-artworkList"></div>');
                    jsonResponse.artwork_list.forEach(function(elem) {
                        $artworkList.append($('<div class="recentlyPopup-imageWrapper">' + '<div class="recentlyPopup-removeArtworkBtn" data-code="' + elem.code + '"></div>' + '<a href="/artwork/' + elem.code + '/" onclick="ga_clk_recentlyview(\'layer_recently_artwork_detail\', \'' + elem.code + '\');">' + '<img src="' + elem.thumb_url + '" alt="썸네일"/>' + '</a>' + '</div>'))
                    });
                    $popupHeader.append($('<div class="recentlyPopup-closeBtn"></div>'));
                    $popupBody.append($artworkList);
                    popupContent.append($popupHeader);
                    popupContent.append($popupBody);
                    function removeFromArray(array, element) {
                        var index = array.indexOf(element);
                        array.splice(index, 1);
                    }
                    $('.recentlyPopup-removeArtworkBtn').click(function() {
                        var recently_viewed_artworks = atob(opg.fn.getCookie('recently_viewed_artworks').replace(/"/gi, ''))
                          , artwork_list = recently_viewed_artworks.split(',').filter(function(n) {
                            return n !== ""
                        })
                          , $artworkCount = $('.recentlyPopup-artworkCount').find('.count')
                          , artwork_count = $artworkCount.text()
                          , $this = $(this);
                        removeFromArray(artwork_list, $this.data('code'));
                        $this.parent().remove();
                        if (artwork_list.length > 0) {
                            recently_viewed_artworks = artwork_list.join(',');
                            $recently_viewed_artwork_count.text(artwork_list.length);
                            recently_viewed_artworks = btoa(recently_viewed_artworks);
                            opg.fn.setCookie('recently_viewed_artworks', recently_viewed_artworks, 7);
                            $artworkCount.text(parseInt(artwork_count) - 1);
                        } else {
                            $recently_viewed_artwork_count.text(0);
                            opg.fn.setCookie('recently_viewed_artworks', '', 7);
                            $artworkCount.text(0);
                            $('#basePage-RecentlyViewedArtworks').find('img').remove();
                            destroy_popup();
                        }
                        ga_clk_recentlyview('layer_recently_remove', $this.data('code'));
                    });
                    $('.recentlyPopup-closeBtn').click(function() {
                        ga_clk_recentlyview('layer_recently_close');
                        destroy_popup();
                    });
                    popupContent.click(function(e) {
                        e.stopPropagation();
                    });
                } else {
                    alert('서버와의 통신이 실패하였습니다.');
                }
            },
            error: function() {
                alert('서버와의 통신이 실패하였습니다.');
            }
        });
        $('#recentlyViewedArtworks-popup').append(popup_wrapper);
    });
});
(function() {
    var allauth = window.allauth = window.allauth || {};
    allauth.facebook = {
        init: function() {
            var self = this;
            this.opts = {
                appId: '426724840795968',
                version: 'v2.5',
                locale: 'ko_KR',
                loginOptions: {
                    scope: 'email,public_profile',
                    return_scopes: true,
                    auth_type: 'rerequest'
                },
                loginByTokenUrl: '/socialaccounts/facebook/login/token/'
            };
            window.fbAsyncInit = function() {
                FB.init({
                    appId: self.opts.appId,
                    version: self.opts.version,
                    status: true,
                    cookie: true,
                    xfbml: true
                });
            }
            ;
            (function(d) {
                var js, id = 'facebook-jssdk';
                if (d.getElementById(id)) {
                    return;
                }
                js = d.createElement('script');
                js.id = id;
                js.async = true;
                js.src = "//connect.facebook.net/" + self.opts.locale + "/sdk.js";
                d.getElementsByTagName('head')[0].appendChild(js);
            }(document));
        },
        login: function(nextUrl, action, process) {
            var self = this;
            if (typeof (FB) == 'undefined') {
                return;
            }
            if (action == 'reauthenticate') {
                self.opts.loginOptions.auth_type = action;
            }
            if (device_type === 0 || device_type === 3) {
                FB.login(function(response) {
                    if (response.authResponse) {
                        if (response.authResponse.grantedScopes.split(',').indexOf('email') > -1) {
                            FB.api('/me?fields=email', function(response2) {
                                if (response2.email !== undefined) {
                                    self.onLoginSuccess.call(self, response, nextUrl, process);
                                } else {
                                    alert('이메일 주소를 가져오지 못했습니다. 페이스북에서 이메일 인증을 하신 뒤 다시 시도해주세요.');
                                }
                            });
                        } else {
                            alert('이메일 주소 제공에 동의해 주셔야 페이스북으로 로그인이 가능합니다.');
                        }
                    }
                }, self.opts.loginOptions);
            } else {
                var permissionUrl = "https://m.facebook.com/" + self.opts.version + "/dialog/oauth?client_id=" + self.opts.appId + "&response_type=token&redirect_uri=" + window.location.origin + "/facebook_login_mobile/?redirect=" + window.location + "&scope=" + self.opts.loginOptions.scope;
                window.location = permissionUrl;
            }
        },
        onLoginSuccess: function(response, nextUrl, process) {
            var self = this
              , data = {
                next: nextUrl || '/socialredirect/',
                process: process,
                access_token: response.authResponse.accessToken,
                expires_in: response.authResponse.expiresIn
            };
            $.ajax({
                type: "POST",
                url: self.opts.loginByTokenUrl,
                data: data,
                success: function() {
                    opg.fn.onLoginSuccess();
                },
                error: function() {
                    window.location.reload(true);
                }
            });
        },
        logout: function(nextUrl) {
            var self = this;
            if (typeof (FB) == 'undefined') {
                return;
            }
            FB.logout(function(response) {
                self.onLogoutSuccess.call(self, response, nextUrl);
            });
        },
        onLogoutSuccess: function(response, nextUrl) {
            ;
        }
    };
    allauth.facebook.init();
}
)();
if (!opg)
    var opg = {};
if (!opg.fn)
    opg.fn = {};
var $document = $(document)
  , $window = $(window)
  , $body = $(document.body)
  , $header = $('#header')
  , $basePageUp = $('#basePage-up')
  , $basePageBack = $('#basePage-back')
  , $discover_header = $('#ds-header')
  , $recentlyViewedArtworkBtn = $('#basePage-RecentlyViewedArtworks')
  , $kakaoPlusBtn = $('#kakaoPlusBtn');
if (!window.location.origin) {
    window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
}
if (!String.prototype.startsWith) {
    String.prototype.startsWith = function(searchString, position) {
        position = position || 0;
        return this.indexOf(searchString, position) === position;
    }
    ;
}
function getScrollbarW() {
    return window.innerWidth - document.body.scrollWidth;
}
function setFixedPosition(right) {
    $header.css({
        right: right
    });
    $basePageUp.css({
        right: right + 10
    });
    $basePageBack.css({
        right: right + 10
    });
    $discover_header.css({
        right: right
    });
    $recentlyViewedArtworkBtn.css({
        right: right + 10
    });
    $kakaoPlusBtn.css({
        right: right + 10
    });
}
var hideScroll = function(e) {
    e.preventDefault();
};
var toggleScroll = function(bool) {
    if (bool === true) {
        document.getElementById('mSide-bottom-loggedOut').addEventListener("touchmove", hideScroll);
        document.getElementById('mSide-bottom-loggedIn').addEventListener("touchmove", hideScroll);
    } else {
        document.getElementById('mSide-bottom-loggedOut').removeEventListener("touchmove", hideScroll);
        document.getElementById('mSide-bottom-loggedIn').removeEventListener("touchmove", hideScroll);
    }
};
opg.fn.hide_mBar = function(callback) {
    toggleScroll(false);
    var $side_bar_mask = $('#mSideMask')
      , $side_menu_bar = $('#mSide-menuBar');
    function hide_mask() {
        $side_bar_mask.unbind('click.m_sidebar').hide();
        $body.css({
            overflowX: $side_bar_mask.data('body_overflow_x'),
            overflowY: $side_bar_mask.data('body_overflow_y'),
            marginRight: 0
        });
        setFixedPosition(0);
        $window.unbind('resize.m_sidebar').scroll();
        if (typeof (callback) === 'function') {
            callback();
        }
    }
    if ($side_menu_bar.hasClass('visible')) {
        $side_menu_bar.animate({
            left: -300
        }, 200, function() {
            hide_mask();
            $side_menu_bar.removeClass('visible');
        });
    }
}
;
opg.fn.show_mMenuBar = function(callback) {
    toggleScroll(true);
    var origin_overflow_x, origin_overflow_y, $side_bar_mask = $('#mSideMask'), $side_menu_bar = $('#mSide-menuBar'), scrollbarWidth, resize_tid;
    function show_() {
        origin_overflow_x = $body.css('overflow-x');
        origin_overflow_y = $body.css('overflow-y');
        scrollbarWidth = getScrollbarW();
        $body.css({
            overflowY: 'hidden',
            marginRight: scrollbarWidth
        });
        setFixedPosition(scrollbarWidth);
        $side_bar_mask.data({
            body_overflow_x: origin_overflow_x,
            body_overflow_y: origin_overflow_y
        }).one('click.m_sidebar', opg.fn.hide_mBar).show();
        $window.on('resize.m_sidebar', function() {
            clearTimeout(resize_tid);
            resize_tid = setTimeout(function() {
                if (window.matchMedia ? !window.matchMedia('(max-width:991px)').matches : window.innerWidth > 991) {
                    opg.fn.hide_mBar();
                }
            }, 200);
        });
        $side_menu_bar.animate({
            left: 0
        }, 200, function() {
            if (typeof (callback) === 'function') {
                callback();
            }
            $side_menu_bar.addClass('visible');
        });
    }
    if ($side_bar_mask.is(':visible')) {
        opg.fn.hide_mBar(show_);
    } else {
        show_();
    }
}
;
opg.fn.noticePopup = function(noti_src, links) {
    var origin_overflow_x = $body.css('overflow-x'), origin_overflow_y = $body.css('overflow-y'), popup_wrapper, overlay = $('<div class="overlay notice"></div>'), x_btn = $('<div class="noti_x_btn"></div>'), scrollbarWidth = getScrollbarW(), image_wrapper = $('<span class="image_wrapper"><img src="' + noti_src + '" /></span>');
    function destroy_popup() {
        if (overlay.hasClass('hidden')) {
            return;
        }
        popup_wrapper.fadeOut(0, function() {
            $(this).remove();
        });
        $body.css({
            overflowX: origin_overflow_x,
            overflowY: origin_overflow_y,
            marginRight: 0
        });
        setFixedPosition(0);
        $window.scroll();
        $document.unbind('.popup');
    }
    popup_wrapper = $('#popup_wrapper');
    if (popup_wrapper.length === 0) {
        popup_wrapper = $('<div id="popup_wrapper"></div>');
        popup_wrapper.hide().appendTo('#wrap').fadeIn(0, function() {
            $body.css({
                overflowY: 'hidden',
                marginRight: scrollbarWidth
            });
            setFixedPosition(scrollbarWidth);
            $document.bind('keydown.popup', function(e) {
                if (e.keyCode === 27 && $('#popup_wrapper_2').length === 0) {
                    destroy_popup();
                }
            });
        });
        popup_wrapper.data({
            body_overflow_x: origin_overflow_x,
            body_overflow_y: origin_overflow_y
        });
    } else {
        origin_overflow_x = popup_wrapper.data('body_overflow_x');
        origin_overflow_y = popup_wrapper.data('body_overflow_y');
        popup_wrapper.empty();
    }
    if (links) {
        var i;
        for (i = 0; i < links.length; i += 1) {
            var link_a = $('<a href="' + links[i].href + '" target="_blank"></a>');
            if (links[i].img) {
                $('<img src="' + links[i].img + '" style="width: 100%; height: 100%;" />').appendTo(link_a);
            }
            link_a.css({
                opacity: 0.5,
                position: 'absolute',
                left: links[i].left,
                top: links[i].top,
                width: links[i].width,
                height: links[i].height
            }).hover(function() {
                $(this).stop().animate({
                    opacity: 1
                }, 150);
            }, function() {
                $(this).stop().animate({
                    opacity: 0.5
                }, 150);
            }).appendTo(image_wrapper);
        }
    }
    x_btn.prependTo(image_wrapper).click(destroy_popup);
    image_wrapper.appendTo(overlay);
    overlay.css({
        opacity: 0
    }).appendTo(popup_wrapper).animate({
        opacity: 1
    }, 200);
}
;
opg.fn.eventPopup = function() {
    var origin_overflow_x = $body.css('overflow-x'), origin_overflow_y = $body.css('overflow-y'), popup_wrapper, overlay = $('<div class="overlay search_address"></div>'), x_btn_wrapper = $('<div class="x_btn_wrapper"><div class="x_btn"></div></div>'), scrollbarWidth = getScrollbarW();
    function destroy_popup() {
        if (overlay.hasClass('hidden')) {
            return;
        }
        popup_wrapper.fadeOut(0, function() {
            $(this).remove();
        });
        $body.css({
            overflowX: origin_overflow_x,
            overflowY: origin_overflow_y,
            marginRight: 0
        });
        setFixedPosition(0);
        $window.scroll();
        $document.unbind('.popup');
    }
    popup_wrapper = $('#popup_wrapper');
    if (popup_wrapper.length === 0) {
        popup_wrapper = $('<div id="popup_wrapper"></div>');
        popup_wrapper.hide().appendTo('#wrap').fadeIn(0, function() {
            $body.css({
                overflowY: 'hidden',
                marginRight: scrollbarWidth
            });
            setFixedPosition(scrollbarWidth);
            $document.bind('keydown.popup', function(e) {
                if (e.keyCode === 27 && $('#popup_wrapper_2').length === 0) {
                    destroy_popup();
                }
            });
        });
        popup_wrapper.data({
            body_overflow_x: origin_overflow_x,
            body_overflow_y: origin_overflow_y
        });
    } else {
        origin_overflow_x = popup_wrapper.data('body_overflow_x');
        origin_overflow_y = popup_wrapper.data('body_overflow_y');
        popup_wrapper.empty();
    }
    x_btn_wrapper.prependTo(overlay).click(destroy_popup);
    $('<div class="search_address_wrapper">\
            <div class="search_address_header">\
                <h2 class="title">안내</h2>\
            </div>\
            <p class="search_address_body" style="margin-top: 30px; line-height: 1.5;">\
                첫 렌탈 할인 이벤트가 6월 18일자로 종료되었습니다.<br/>\
                보다 다양한 혜택을 담은 이벤트로 다시 찾아오겠습니다.<br/>\
                <br/>\
                그림렌탈 상담 신청<br/>\
                전화 상담: 02-6949-3530<br/>\
                카카오톡 플러스친구 채팅 상담 :&nbsp;&nbsp;<a href="https://pf.kakao.com/_xdWtxbl/chat" target="_blank" style="text-decoration: underline;">바로가기</a><br/>\
            </p>\
        </div>').appendTo(overlay);
    overlay.css({
        opacity: 0
    }).appendTo(popup_wrapper).animate({
        opacity: 1
    }, 200);
}
;

opg.fn.detailView_init = function($elem, code, is_over_100) {
    var $imageCarousel = $elem.find('.artworkDetail-imageCarousel')
      , $imagePagination = $elem.find('.artworkDetail-imagePagination')
      , $pageCarousel = $imagePagination.find('.artworkDetail-pageCarousel')
      , $viewinroompreviewCarousel = $elem.find('.artworkDetail-viewinroom-content .owl-carousel')
      , $viewinroomImgWrap = $elem.find('.artworkDetail-viewinroom-img-wrap')
      , $viewinroomCarousel = $viewinroomImgWrap.find('.owl-carousel')
      , $viewinroomImgArtwork = $elem.find('.artworkDetail-viewinroom-img-artwork')
      , $viewinroombackgroundColor = $elem.find('.artworkDetail-viewinroom-background-color')
      , $artworkDetailViewinroomTagSpace = $elem.find('.artworkDetail-viewinroom-tag_space')
      , $artworkDetailViewinroomTagColor = $elem.find('.artworkDetail-viewinroom-tag_color')
      , $shadow = $elem.find('.shadow')
      , page_length = Math.min(5, $pageCarousel.find('.artworkDetail-pageItem').length)
      , view_in_room_width = $viewinroomImgArtwork.data('view_in_room_width')
      , ratio = $viewinroomImgArtwork.data('ratio')
      , rental_rate = $elem.find('input[name=rental_rate_value]').val();
    $elem.find('.artworkDetail-codeCopyBtn').click(function() {
        function l() {
            if (!document.queryCommandSupported || !document.queryCommandSupported('copy')) {
                return false;
            }
            var result = false
              , u = document.createRange()
              , t = window.getSelection()
              , onselectstart = document.body.onselectstart;
            document.body.onselectstart = null;
            u.selectNodeContents($elem.find('.artworkDetail-codeCopyText')[0]);
            t.removeAllRanges();
            t.addRange(u);
            try {
                result = document.execCommand('copy');
            } catch (err) {}
            if (window.getSelection().getRangeAt(0).getClientRects().length > 0) {
                window.getSelection().removeAllRanges();
            }
            document.body.onselectstart = onselectstart;
            return result;
        }
        if (navigator.userAgent.toLowerCase().indexOf("gecko") !== -1) {
            if (!l()) {
                prompt('아래의 코드를 복사(Ctrl+C)하여\n원하는 곳에 붙여넣기(Ctrl+V)하세요.', code);
            }
        } else {
            window.clipboardData.setData("Text", code);
        }
    });
    $elem.find('.artworkDetail-codeCopyBtn').on('mouseleave', function() {
        $(this).removeClass('tooltipped tooltipped-s');
    });
    $imagePagination.css('width', 50 * page_length + 68);
    $imageCarousel.on('changed.owl.carousel', function(event) {
        var current = event.item.index;
        $pageCarousel.find(".owl-item").removeClass("synced").eq(current).addClass("synced");
        center($pageCarousel, current);
    });
    $imageCarousel.owlCarousel({
        items: 1,
        mouseDrag: false,
        touchDrag: false,
        dots: false
    });
    if (page_length !== 1) {
        if (page_length === 5) {
            $pageCarousel.addClass('full');
        }
        $pageCarousel.on("initialized.owl.carousel", function(event) {
            $pageCarousel.find(".owl-item").eq(0).addClass("synced");
        });
        $pageCarousel.on("click", ".owl-item", function() {
            var index = $(this).index();
            $imageCarousel.trigger("to.owl.carousel", [index, 200]);
        });
        $pageCarousel.owlCarousel({
            items: page_length,
            nav: true,
            dots: false,
            rewind: true,
            navText: ["", ""]
        });
    }
    $viewinroompreviewCarousel.on('initialized.owl.carousel', function() {
        $(this).find(".owl-item").eq(0).addClass("synced");
    });
    $viewinroomCarousel.on('changed.owl.carousel', function(event) {
        var current = event.item.index;
        $viewinroompreviewCarousel.find(".owl-item").removeClass("synced").eq(current).addClass("synced");
        center($viewinroompreviewCarousel, current);
        $('.current-item').text(current + 1);
        $('.max-items').text(event.item.count);
    });
    $viewinroomCarousel.owlCarousel({
        items: 1,
        lazyLoad: true,
        mouseDrag: false,
        touchDrag: false,
        dots: false
    });
    $viewinroomCarousel.find('.owl-stage').off('mousedown.owl.core selectstart.owl.core touchstart.owl.core touchcancel.owl.core');
    $viewinroompreviewCarousel.owlCarousel({
        responsive: {
            0: {
                items: 4
            },
            544: {
                items: 5
            },
            768: {
                items: 4
            }
        },
        nav: true,
        navText: ["", ""],
        margin: 12,
        dots: false,
        rewind: false
    });
    $viewinroompreviewCarousel.on("click", ".owl-item", function(e) {
        e.preventDefault();
        var index = $(this).index();
        $viewinroomCarousel.trigger("to.owl.carousel", [index, 0]);
        var space = $(this).find(".item-description").text();
        $artworkDetailViewinroomTagSpace.text(space);
    });
    function center(carousel, number) {
        var sync2visible = [];
        var items = [];
        carousel.find(".owl-item").each(function() {
            items.push($(this).index());
            if ($(this).is(".active")) {
                sync2visible.push($(this).index());
            }
        });
        var num = number;
        var found = false;
        for (var i in sync2visible) {
            if (num === sync2visible[i]) {
                var found = true;
            }
        }
        if (found === false) {
            if (num > sync2visible[sync2visible.length - 1]) {
                carousel.trigger("to.owl.carousel", [num - sync2visible.length + 2, 0]);
            } else {
                if (num - 1 === -1) {
                    num = 0;
                }
                carousel.trigger("to.owl.carousel", [num, 0]);
            }
        } else if (num === sync2visible[sync2visible.length - 1]) {
            if (num !== items[items.length - 1]) {
                carousel.trigger("to.owl.carousel", [sync2visible[1], 0]);
            }
        } else if (num === sync2visible[0]) {
            if (num !== 0) {
                num = num - 1;
            }
            carousel.trigger("to.owl.carousel", [num, 0]);
        }
    }
    function getTransform(el) {
        var transform_value = $(el).css('-webkit-transform') || ''
          , results = transform_value.match(/matrix(?:(3d)\(-?\d+\.?\d*(?:, -?\d+\.?\d*)*(?:, (-?\d+\.?\d*))(?:, (-?\d+\.?\d*))(?:, (-?\d+\.?\d*)), -?\d+\.?\d*\)|\(-?\d+\.?\d*(?:, -?\d+\.?\d*)*(?:, (-?\d+\.?\d*))(?:, (-?\d+\.?\d*))\))/)
        if (!results)
            return [0, 0, 0];
        if (results[1] == '3d')
            return results.slice(2, 5);
        results.push(0);
        return results.slice(5, 8);
    }
    var width = Math.floor($viewinroomImgWrap.width() * 0.003 * view_in_room_width);
    var height = Math.floor(width * ratio);
    $viewinroomImgArtwork.css({
        'width': width + 'px',
        'height': height + 'px',
        '-webkit-transform': 'translate(-50%,-50%)',
        '-ms-transform': 'translate(-50%,-50%)',
        'transform': 'translate(-50%,-50%)'
    });
    $shadow.css({
        'width': width + 'px',
        'height': height + 'px',
        '-webkit-transform': 'translate(-50%,-50%)',
        '-ms-transform': 'translate(-50%,-50%)',
        'transform': 'translate(-50%,-50%)'
    });
    if ($viewinroomImgArtwork.length > 0) {
        $(window).resize(function() {
            width = Math.floor($viewinroomImgWrap.width() * 0.003 * view_in_room_width);
            height = Math.floor(width * ratio);
            $viewinroomImgArtwork.css({
                'width': width + 'px',
                'height': height + 'px'
            });
            $shadow.css({
                'width': width + 'px',
                'height': height + 'px'
            });
            var results = getTransform($viewinroomImgArtwork);
            $shadow.css({
                "transform": "translate3d(" + results[0] + "px, " + results[1] + "px, " + results[2] + "px)"
            });
        });
    }
    function onDrag() {
        var results = getTransform($viewinroomImgArtwork);
        $shadow.css({
            "transform": "translate3d(" + results[0] + "px, " + results[1] + "px, " + results[2] + "px)"
        });
    }
    function onDragEnd() {
        dataLayer.push({
            'event': 'detail_action',
            'eventLabel': 'view_in_room_drag'
        });
    }
    $('.artworkDetail-viewinroom-content .item').click(function(e) {
        dataLayer.push({
            'event': 'detail_action',
            'eventLabel': 'change_space_to_' + $(this.children[0]).attr('alt')
        });
    });
    $('.artworkDetail-viewinroom-choice .item').click(function(e) {
        dataLayer.push({
            'event': 'detail_action',
            'eventLabel': 'click_space: ' + $(this.children[0]).attr('alt')
        });
    });
    $('.artworkDetail-viewinroom-background-color').click(function(e) {
        dataLayer.push({
            'event': 'detail_action',
            'eventLabel': 'change_color_to_' + $(this).attr('data-class')
        });
    });
    if ($viewinroomImgArtwork.height() > 0) {
        Draggable.create($viewinroomImgArtwork, {
            throwProps: true,
            type: "x,y",
            onDrag: onDrag,
        })[0].addEventListener('dragend', onDragEnd);
    } else {
        $viewinroomImgArtwork.on('load', function() {
            Draggable.create($viewinroomImgArtwork, {
                throwProps: true,
                type: "x,y",
                onDrag: onDrag,
            })[0].addEventListener('dragend', onDragEnd);
        });
    }
    $viewinroombackgroundColor.on("click", function(e) {
        var color = $(this).data("color");
        $viewinroombackgroundColor.removeClass("synced");
        $(this).addClass("synced");
        $viewinroomCarousel.css("background", color);
        $artworkDetailViewinroomTagColor.html($(this).data("name") + "<span class='artworkDetail-viewinroom-tag-mark " + $(this).data("class") + "'></span>");
    });
    $pageCarousel.on("click", ".owl-item", function(e) {
        e.preventDefault();
        var number = $(this).data("owlItem");
        $imageCarousel.trigger("owl.goTo", number);
    });
    $elem.find('.artworkDetail-collectionBox').click(function() {
        var $this = $(this)
          , artwork_code = $this.data('code');
        if ($this.hasClass('collected')) {
            opg.fn.remove_from_collection('artwork', artwork_code, function() {
                $this.removeClass('collected');
            });
            dataLayer.push({
                event: 'detail_action',
                eventLabel: 'mycollection_delete',
                artworkCode: artwork_code
            });
        } else {
            opg.fn.add_to_collection('artwork', artwork_code, function() {
                $this.addClass('collected');
            });
            dataLayer.push({
                event: 'detail_action',
                eventLabel: 'mycollection_add',
                artworkCode: artwork_code
            });
        }
    });
    $elem.find('.artworkDetail-shareButton').click(function() {
        opg.fn.shareBox(this, 'detail_action');
    });
    if (document.URL.indexOf('sp') > -1) {
        var getUrlParameter = function getUrlParameter(sParam) {
            var sPageURL = decodeURIComponent(window.location.search.substring(1)), sURLVariables = sPageURL.split('&'), sParameterName, i;
            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');
                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : sParameterName[1];
                }
            }
        };
        var $space_item = $elem.find('.artworkDetail-viewinroom-content .item').parent();
        var sp = getUrlParameter('sp');
        $space_item.each(function() {
            if ($(this).children().data('evspace') === sp) {
                $(this).trigger('click');
            } else {
                $(this).removeClass('synced');
            }
        })
    }
    if (is_over_100) {
        $viewinroompreviewCarousel.trigger('owl.jumpTo', 5);
        $viewinroomCarousel.trigger("owl.jumpTo", 5);
        $viewinroomImgArtwork.addClass('over_100');
        $shadow.addClass('over_100');
    }
    dataLayer.push({
        'event': 'artwork_detail_pageview',
        'eventLabel': 'ArtworkDetail'
    });
    /*fbq('track', 'ViewContent', {
        content_ids: [code],
        content_type: 'product',
        value: rental_rate,
        currency: 'KRW'
    });*/
    /*kakaoPixel('1052010801340985911').viewContent({
        id: code
    });*/
}
;
opg.fn.gtm_login_data = function(login_type) {
    window.dataLayer = window.dataLayer || [];
    dataLayer.push({
        'loginType': login_type,
        'event': 'loginComplete'
    });
}
;
opg.fn.loginPopup = function() {
    if (window.location.pathname === '/login/') {
        window.location.reload(true);
        return;
    }
    var origin_overflow_x = $body.css('overflow-x'), origin_overflow_y = $body.css('overflow-y'), popup_wrapper, overlay = $('<div class="overlay auth"></div>'), scrollbarWidth = getScrollbarW();
    function destroy_popup() {
        if (popup_wrapper.find('.overlay.hidden').length) {
            overlay.remove();
            popup_wrapper.find('.overlay.hidden').show().removeClass('hidden');
            $document.unbind('.popup.auth');
            return;
        }
        popup_wrapper.fadeOut(0, function() {
            $(this).remove();
        });
        $body.css({
            overflowX: origin_overflow_x,
            overflowY: origin_overflow_y,
            marginRight: 0
        });
        setFixedPosition(0);
        $window.scroll();
        $document.unbind('.popup.auth');
    }
    $header.removeClass('search_active');
    popup_wrapper = $('#popup_wrapper');
    if (popup_wrapper.length === 0) {
        popup_wrapper = $('<div id="popup_wrapper"></div>');
        popup_wrapper.hide().appendTo('#wrap').fadeIn(0, function() {
            $body.css({
                overflowY: 'hidden',
                marginRight: scrollbarWidth
            });
            setFixedPosition(scrollbarWidth);
            $document.bind('keydown.popup.auth', function(e) {
                if (e.keyCode === 27 && $('#popup_wrapper_2').length === 0) {
                    destroy_popup();
                }
            });
        });
        popup_wrapper.data({
            body_overflow_x: origin_overflow_x,
            body_overflow_y: origin_overflow_y
        });
    } else {
        origin_overflow_x = popup_wrapper.data('body_overflow_x');
        origin_overflow_y = popup_wrapper.data('body_overflow_y');
        $document.unbind('keydown.popup.auth');
        popup_wrapper.find('.overlay').each(function() {
            var $el = $(this);
            if ($el.hasClass('auth')) {
                $el.remove();
            } else {
                $el.hide().addClass('hidden');
            }
        });
        $document.bind('keydown.popup.auth', function(e) {
            if (e.keyCode === 27 && $('#popup_wrapper_2').length === 0) {
                destroy_popup();
            }
        });
    }
    (function() {
        var $loginPopup = $('<div id="loginPopup">' + '<div id="loginPopup-closeOverlayBtn"></div>' + '<div id="loginPopup-header">로그인</div>' + '<div id="loginPopup-body">' + '<form method="post" action="/login/">' + '<input type="email" name="email" id="loginPopup-input-email" class="loginPopup-input" autocomplete="off" autocorrect="off" autocapitalize="off" placeholder="이메일" />' + '<input type="password" name="password" id="loginPopup-input-password" class="loginPopup-input" autocomplete="off" autocorrect="off" autocapitalize="off" maxlength="20" placeholder="비밀번호" />' + '<div id="loginPopup-message"></div>' + '<input type="submit" class="loginPopup-button" name="_signin_with_email" value="로그인" />' + '<div class="fakebox longbox">' + '<input id="login_checkbox_layer" type="checkbox" class="consult-check" value="로그인 상태 유지" name="keep_login">' + '<label for="login_checkbox_layer">' + '<div>로그인 상태 유지</div>' + '</label>' + '</div>' + '<div id="loginPopup-resetPassword" class="cf">' + '<a href="/account/password/reset/" target="_blank">비밀번호 찾기</a>' + '</div>' + '</form>' + '<div id="loginPopup-separator"><span>또는</span></div>' + '<input type="button" class="loginPopup-button facebook" value="페이스북으로 로그인" />' + '<div id="naverIdLogin">' + '<a id="naverIdLogin_loginButton" href="javascript:void(null);"><input type="button" class="loginPopup-button naver" value="네이버로 로그인"></a>' + '</div>' + '<div id="kakaoLogin">' + '<a id="kakaoLogin_loginButton" href="/accounts/kakao/login/" target="_blank"><input type="button" class="loginPopup-button kakao" value="카카오로 로그인"></a>' + '</div>' + '</div>' + '<div id="loginPopup-footer">' + '<span>아직 회원이 아니시라면?</span>' + '<a href="/join/">오픈갤러리 회원가입</a>' + '</div>' + '</div>')
          , $form = $loginPopup.find('form')
          , $msg = $form.find('#loginPopup-message')
          , $inputs = $form.find('.loginPopup-input')
          , $input_email = $inputs.filter('#loginPopup-input-email')
          , $input_password = $inputs.filter('#loginPopup-input-password');
        function validate_form() {
            var result = true;
            $msg.text('');
            if (!/^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/.test($input_email.val())) {
                result = false;
            }
            if ($input_password.val().length < 6) {
                result = false;
            }
            if (!result) {
                $msg.text('이메일 또는 비밀번호가 올바르지 않습니다.');
            }
            return result;
        }
        $loginPopup.find('#login_checkbox_layer').change(function() {
            if ($('#login_checkbox_layer').is(':checked') === true) {
                alert('개인정보보호를 위해 개인 기기에서만 체크해주세요.');
            }
        });
        $loginPopup.find('#loginPopup-closeOverlayBtn').click(function(e) {
            destroy_popup();
        });
        $loginPopup.find('.loginPopup-button.facebook').click(function(e) {
            allauth.facebook.login('', 'authenticate', 'login');
            opg.fn.gtm_login_data('페이스북 로그인');
            e.preventDefault();
        });
        $loginPopup.find('.loginPopup-button.naver').click(function(e) {
            opg.fn.gtm_login_data('네이버 로그인');
            e.preventDefault();
        });
        $loginPopup.find('.loginPopup-button.naver').click(function(e) {
            opg.fn.gtm_login_data('카카오 로그인');
            e.preventDefault();
        });
        $inputs.focus(function() {
            $msg.text('');
        });
        $input_email.change(function() {
            var value = $input_email.val()
              , trimmed = value.trim();
            if (trimmed !== value) {
                $input_email.val(trimmed);
            }
        });
        $form.submit(function(e) {
            var formAction = $form.attr("action");
            var formData = $form.serializeArray();
            e.preventDefault();
            if (!$form.hasClass('waiting') && validate_form()) {
                $form.addClass('waiting');
                $.ajax({
                    type: "POST",
                    url: formAction,
                    data: formData,
                    dataType: 'json',
                    success: function(jsonResponse) {
                        if (jsonResponse.success) {
                            opg.fn.gtm_login_data('일반 로그인');
                            opg.fn.onLoginSuccess();
                            window.location.reload();
                        } else {
                            switch (jsonResponse.reason) {
                            case 'not_verified':
                                $msg.text('이메일 인증 완료 후 다시 시도해 주십시오.');
                                break;
                            case 'dormant_user':
                                $msg.text('휴면 계정 복구 후에 다시 시도해 주십시오.');
                                if (confirm('휴면 상태로 전환된 계정입니다. 복구 페이지로 이동하시겠습니까?')) {
                                    location.href = '/account/reactivate/' + jsonResponse.uidb36 + '/';
                                }
                                break;
                            default:
                                $msg.text('이메일 또는 비밀번호가 올바르지 않습니다.');
                            }
                            $form.removeClass('waiting');
                        }
                    },
                    error: function() {
                        alert('로그인 중 오류가 발생하였습니다. 다시 시도해주십시오.');
                        opg.fn.loginPopup();
                    }
                });
            }
        });
        $loginPopup.appendTo(overlay);
    }
    )();
    overlay.hide().appendTo(popup_wrapper).fadeIn(200);
    var naverLogin = new naver.LoginWithNaverId({
        clientId: "6ghs1ZQFkv5FA8RqegKy",
        callbackUrl: location.protocol + "//" + window.location.hostname + ((location.port == "" || location.port == undefined) ? "" : ":" + location.port) + "/naver_login_callback/",
        isPopup: true
    });
    naverLogin.init();
    opg.fn.setCookie('login_redirect_url', location.pathname, 1);
}
;
opg.fn.destroy_popup = function() {
    var popup_wrapper = $('#popup_wrapper')
      , origin_overflow_x = popup_wrapper.data('body_overflow_x')
      , origin_overflow_y = popup_wrapper.data('body_overflow_y');
    if (popup_wrapper.find('.overlay.hidden').length) {
        popup_wrapper.find('.overlay:not(.hidden)').remove();
        popup_wrapper.find('.overlay.hidden').show().removeClass('hidden');
        $document.unbind('.popup.auth');
        return;
    }
    popup_wrapper.fadeOut(0, function() {
        $(this).remove();
    });
    $body.css({
        overflowX: origin_overflow_x,
        overflowY: origin_overflow_y,
        marginRight: 0
    });
    setFixedPosition(0);
    $window.scroll();
    $document.unbind('.popup');
}
;
opg.fn.panzoomPopup = function(img_src) {
    var origin_overflow_x = $body.css('overflow-x'), origin_overflow_y = $body.css('overflow-y'), origin_marginRight = $body.css('margin-right'), popup_wrapper, overlay = $('<div class="overlay panzoom"></div>'), panzoom_header = $('<div class="panzoom_header"></div>'), x_btn = $('<div class="x_btn"></div>'), scrollbarWidth = getScrollbarW(), $panzoom = $('<img src="' + img_src + '" class="img_to_panzoom" />'), zoomRange = $('<input type="range" class="zoom-range" />').hide();
    function destroy_popup() {
        popup_wrapper.fadeOut(0, function() {
            $(this).remove();
        });
        if ($('#popup_wrapper').length === 0) {
            $body.css({
                overflowX: origin_overflow_x,
                overflowY: origin_overflow_y,
                marginRight: 0
            });
            setFixedPosition(0);
            $document.unbind('.popup2');
            $window.unbind('.panzoom_resize').scroll();
        } else {
            $document.unbind('.popup2');
            $window.unbind('.panzoom_resize');
        }
    }
    function init_panzoom() {
        $panzoom.panzoom({
            cursor: 'pointer',
            startTransform: 'scale(0.5)',
            minScale: 0.5,
            maxScale: 2,
            increment: 0.1,
            rangeStep: 0.1,
            $zoomRange: zoomRange
        });
        $panzoom.on('panzoompan', position_correction);
        $panzoom.on('panzoomzoom', position_correction);
        $window.bind('resize.panzoom_resize', function() {
            $panzoom.css('margin-top', parseInt((overlay.innerHeight() - $panzoom.outerHeight()) / 2, 10));
            position_correction();
        });
        overlay.on('mousewheel', function(e) {
            e.preventDefault();
            var delta = e.delta || e.originalEvent.wheelDelta;
            var zoomOut = delta ? delta < 0 : e.originalEvent.deltaY > 0;
            $panzoom.panzoom('zoom', zoomOut);
        });
        overlay.animate({
            opacity: 1
        }, 200);
        zoomRange.fadeIn(200);
    }
    function position_correction() {
        var pp = $panzoom.parent(), p_h = pp.innerHeight(), p_w = pp.innerWidth(), m = $panzoom.panzoom('getMatrix'), r = m[0], x = m[4], y = m[5], h = $panzoom.height() * r, w = $panzoom.width() * r, t_x, t_y;
        if (w <= p_w) {
            x = 0;
        } else {
            t_x = parseInt((w - p_w) / 2, 10);
            if (x < -t_x) {
                x = -t_x;
            } else if (x > t_x) {
                x = t_x;
            }
        }
        if (h <= p_h) {
            y = 0;
        } else {
            t_y = parseInt((h - p_h) / 2, 10);
            if (y < -t_y) {
                y = -t_y;
            } else if (y > t_y) {
                y = t_y;
            }
        }
        $panzoom.panzoom('pan', x, y, {
            silent: true
        });
    }
    popup_wrapper = $('#popup_wrapper_2');
    if (popup_wrapper.length === 0) {
        popup_wrapper = $('<div id="popup_wrapper_2"></div>');
        popup_wrapper.hide().appendTo('#wrap').fadeIn(0, function() {
            if ($('#popup_wrapper').length === 0) {
                $body.css({
                    overflowY: 'hidden',
                    marginRight: scrollbarWidth
                });
                setFixedPosition(scrollbarWidth);
            }
            $document.bind('keydown.popup2', function(e) {
                if (e.keyCode === 27) {
                    if (location.hash.startsWith('#zoom')) {
                        window.history.back();
                    } else {
                        destroy_popup();
                    }
                }
            });
        });
        popup_wrapper.data({
            body_overflow_x: origin_overflow_x,
            body_overflow_y: origin_overflow_y,
            body_marginRight: origin_marginRight
        });
    } else {
        origin_overflow_x = popup_wrapper.data('body_overflow_x');
        origin_overflow_y = popup_wrapper.data('body_overflow_y');
        popup_wrapper.empty();
    }
    $panzoom.css('transform', 'none').appendTo(overlay);
    x_btn.click(function() {
        if (location.hash.startsWith('#zoom')) {
            history.back();
        } else {
            destroy_popup();
        }
    }).appendTo(panzoom_header);
    zoomRange.appendTo(panzoom_header);
    panzoom_header.appendTo(popup_wrapper);
    overlay.css({
        opacity: 0
    }).appendTo(popup_wrapper);
    $panzoom.one('load', function() {
        setTimeout(function() {
            $panzoom.css('margin-top', parseInt((overlay.innerHeight() - $panzoom.outerHeight()) / 2, 10));
            init_panzoom();
        }, 0);
    }).each(function() {
        if (this.complete) {
            $(this).trigger('load');
        }
    });
    $document.on('touchmove.popup2', function(e) {});
}
;
opg.fn.destroy_popup_2 = function() {
    var popup_wrapper = $('#popup_wrapper_2'), origin_overflow_x, origin_overflow_y, origin_marginRight;
    if (popup_wrapper.length) {
        origin_overflow_x = popup_wrapper.data('body_overflow_x');
        origin_overflow_y = popup_wrapper.data('body_overflow_y');
        origin_marginRight = popup_wrapper.data('body_marginRight');
        popup_wrapper.fadeOut(0, function() {
            $(this).remove();
        });
        $body.css({
            overflowX: origin_overflow_x,
            overflowY: origin_overflow_y,
            marginRight: origin_marginRight
        });
        setFixedPosition(origin_marginRight);
        $document.unbind('.popup2');
        $window.unbind('.panzoom_resize').scroll();
    }
}
;
opg.fn.updateUserBox = function() {
    var user_box = $('#userBox');
    $.ajax({
        type: "GET",
        url: "/get/user_box/",
        dataType: 'json',
        success: function(jsonResponse) {
            user_box.fadeOut(100, function() {
                if (jsonResponse.success) {
                    $('#userBox-name').text(jsonResponse.user_name);
                    $('#mUserBox-name').append($('<span class="bold">' + jsonResponse.user_name + '</span>')).append($('<span>님 반갑습니다.</span>'));
                    $(this).add('#mSide-menuBar').addClass('logged_in');
                    uKey = jsonResponse.ukey;
                    dataLayer.push({
                        'uKey': uKey,
                        'deviceType': device_type,
                        'userAgent': user_agent
                    });
                } else {
                    $('#userBox-name, #mUserBox-name').text('');
                    $(this).add('#mSide-menuBar').removeClass('logged_in');
                }
                $(this).fadeIn(100);
            });
        },
        error: function(e) {
            if (e.readyState !== 0) {
                alert('네트워크에 연결할 수 없습니다.');
            }
        }
    });
}
;
opg.fn.check_user_signed_up = function() {
    $.ajax({
        type: 'GET',
        url: '/check/user_signed_up/',
        data: {},
        dataType: 'json',
        success: function(jsonResponse) {
            if (jsonResponse.success && jsonResponse.user_signed_up) {
                dataLayer.push({
                    'event': 'user_action',
                    'eventLabel': 'signed_up'
                });
                /*fbq('track', 'CompleteRegistration');*/
                naver_wcs('2');
                daum_cts('M');
            }
        }
    });
}
;
opg.fn.onLoginSuccess = function() {
    var $contents = $('#contents');
    opg.fn.updateUserBox();
    opg.fn.destroy_popup();
    if ($contents.data('reload_after_login')) {
        window.location.reload();
    } else if ($contents.data('redirect_after_login')) {
        window.location.href = $contents.data('redirect_after_login');
    } else {
        opg.fn.check_user_signed_up();
    }
}
;
opg.fn.logout = function() {
    var login_required = $('#contents').data('login_required') || true;
    $.ajax({
        type: 'POST',
        url: '/logout/',
        data: {},
        dataType: 'json',
        success: function(jsonResponse) {
            if (jsonResponse.success) {
                if (login_required) {
                    window.location.reload();
                } else {
                    opg.fn.updateUserBox();
                }
            } else {
                window.location.href = '/logout/';
            }
        },
        error: function() {
            window.location.href = '/logout/';
        }
    });
}
;
opg.fn.add_to_collection = function(content_type, codes, callback) {
    var content_type_dsp, content_type_josa, codes_is_array = true;
    if (content_type === 'artist') {
        content_type_dsp = '작가';
        content_type_josa = 1;
    } else if (content_type === 'artwork') {
        content_type_dsp = '작품';
        content_type_josa = 2;
    } else if (content_type === 'exhibition') {
        content_type_dsp = '전시';
        content_type_josa = 1;
    } else {
        alert('유효하지 않은 동작입니다.');
        return;
    }
    if (!$('#userBox').hasClass('logged_in')) {
        alert('마이컬렉션에 ' + content_type_dsp + (content_type_josa === 1 ? '를' : '을') + ' 추가하려면 먼저 로그인하셔야 합니다.');
        opg.fn.loginPopup();
        return;
    }
    if (!Array.isArray(codes)) {
        if (typeof codes === 'undefined') {
            codes = [];
        } else if (typeof codes === 'string') {
            codes = codes.split(',');
        } else {
            codes = [codes];
        }
        codes_is_array = false;
    }
    $.ajax({
        type: "POST",
        url: '/mycollection/add/',
        data: {
            content_type: content_type,
            code: codes
        },
        dataType: 'json',
        success: function(jsonResponse) {
            if (jsonResponse.success) {
                /*fbq('track', 'AddToWishlist');*/
                if (typeof (callback) === 'function') {
                    callback();
                } else if (codes_is_array) {
                    alert('선택 ' + content_type_dsp + (content_type_josa === 1 ? '가' : '이') + ' 마이컬렉션에 추가되었습니다.');
                }
            } else {
                switch (jsonResponse.reason) {
                case 'not_logged_in':
                    alert('마이컬렉션에 ' + content_type_dsp + (content_type_josa === 1 ? '를' : '을') + ' 추가하려면 먼저 로그인하셔야 합니다.');
                    opg.fn.loginPopup();
                    break;
                case 'already_added':
                    if (typeof (callback) === 'function') {
                        callback();
                    } else if (codes_is_array) {
                        alert('선택 ' + content_type_dsp + (content_type_josa === 1 ? '가' : '이') + ' 마이컬렉션에 추가되었습니다.');
                    }
                    break;
                }
            }
        },
        error: function() {
            alert('유효하지 않은 동작입니다.');
        }
    });
}
;
opg.fn.remove_from_collection = function(content_type, codes, callback) {
    var content_type_dsp, content_type_josa, codes_is_array = true;
    if (content_type === 'artist') {
        content_type_dsp = '작가';
        content_type_josa = 1;
    } else if (content_type === 'artwork') {
        content_type_dsp = '작품';
        content_type_josa = 2;
    } else if (content_type === 'exhibition') {
        content_type_dsp = '전시';
        content_type_josa = 1;
    } else {
        alert('유효하지 않은 동작입니다.');
        return;
    }
    if (!Array.isArray(codes)) {
        if (typeof codes === 'undefined') {
            codes = [];
        } else if (typeof codes === 'string') {
            codes = codes.split(',');
        } else {
            codes = [codes];
        }
        codes_is_array = false;
    }
    if (codes.length === 0) {
        return;
    }
    $.ajax({
        type: "POST",
        url: '/mycollection/remove/',
        data: {
            content_type: content_type,
            code: codes
        },
        dataType: 'json',
        success: function(jsonResponse) {
            if (jsonResponse.success) {
                if (typeof (callback) === 'function') {
                    callback();
                } else if (codes_is_array) {
                    alert('선택 ' + content_type_dsp + (content_type_josa === 1 ? '가' : '이') + ' 마이컬렉션에서 제외되었습니다.');
                }
            } else if (jsonResponse.reason === 'not_logged_in') {
                alert(content_type_dsp + (content_type_josa === 1 ? '를' : '을') + ' 마이컬렉션에서 제외하려면 먼저 로그인하셔야 합니다.');
                opg.fn.loginPopup();
            }
        },
        error: function() {
            alert('유효하지 않은 동작입니다.');
        }
    });
}
;
opg.fn.add_to_cart = function(type, artwork_codes, rental_rate) {
    var cart_type, cart_type_dsp;
    if (type === 'r') {
        cart_type = 'rental';
        cart_type_dsp = '렌탈';
    } else if (type === 'p') {
        cart_type = 'purchase';
        cart_type_dsp = '구매';
    } else {
        alert('유효하지 않은 동작입니다.');
        return;
    }
    if (!$('#userBox').hasClass('logged_in')) {
        alert('작품을 카트에 담으려면 먼저 로그인하셔야 합니다.');
        opg.fn.loginPopup();
        return;
    }
    if (!Array.isArray(artwork_codes)) {
        if (typeof artwork_codes === 'undefined') {
            artwork_codes = [];
        } else if (typeof artwork_codes === 'string') {
            artwork_codes = artwork_codes.split(',');
        } else {
            artwork_codes = [artwork_codes];
        }
    }
    $.ajax({
        type: "POST",
        url: '/cart/add/',
        data: {
            type: type,
            artwork_code: artwork_codes
        },
        dataType: 'json',
        success: function(jsonResponse) {
            if (jsonResponse.success) {
                /*fbq('track', 'AddToCart', {
                    content_ids: artwork_codes,
                    content_type: 'product',
                    value: rental_rate,
                    currency: 'KRW'
                });*/
                if (confirm(cart_type_dsp + '카트에 작품이 담겼습니다. ' + cart_type_dsp + ' 카트로 이동하시겠습니까?')) {
                    window.location.href = '/cart/' + cart_type + '/';
                }
            } else {
                switch (jsonResponse.reason) {
                case 'not_logged_in':
                    alert('작품을 카트에 담으려면 먼저 로그인하셔야 합니다.');
                    opg.fn.loginPopup();
                    break;
                case 'already_added':
                    if (confirm('이미 ' + cart_type_dsp + '카트에 담긴 작품입니다. ' + cart_type_dsp + ' 카트로 이동하시겠습니까?')) {
                        window.location.href = '/cart/' + cart_type + '/';
                    }
                    break;
                }
            }
        },
        error: function() {
            alert('유효하지 않은 동작입니다.');
        }
    });
}
;
opg.fn.remove_from_cart = function(type, artwork_codes) {
    if (type !== 'r' && type !== 'p') {
        alert('유효하지 않은 동작입니다.');
        return;
    }
    if (!Array.isArray(artwork_codes)) {
        if (typeof artwork_codes === 'undefined') {
            artwork_codes = [];
        } else if (typeof artwork_codes === 'string') {
            artwork_codes = artwork_codes.split(',');
        } else {
            artwork_codes = [artwork_codes];
        }
    }
    if (artwork_codes.length === 0) {
        return;
    }
    $.ajax({
        type: "POST",
        url: '/cart/remove/',
        data: {
            type: type,
            artwork_code: artwork_codes
        },
        dataType: 'json',
        success: function(jsonResponse) {
            if (!jsonResponse.success && jsonResponse.reason === 'not_logged_in') {
                alert('작품을 카트에서 제외하려면 먼저 로그인하셔야 합니다.');
            }
            window.location.reload(true);
        },
        error: function() {
            alert('유효하지 않은 동작입니다.');
            window.location.reload(true);
        }
    });
}
;
opg.fn.goToBuy = function(artwork_ids) {
    if (!$('#userBox').hasClass('logged_in')) {
        alert('작품을 구매하려면 먼저 로그인하셔야 합니다.');
        opg.fn.loginPopup();
        return;
    }
    if (Object.prototype.toString.call(artwork_ids) !== '[object Array]') {
        if (typeof artwork_ids === 'undefined') {
            artwork_ids = [];
        } else if (typeof artwork_ids === 'string') {
            artwork_ids = artwork_ids.split(',');
        } else {
            artwork_ids = [artwork_ids];
        }
    }
    post('/checkout/', {
        order_type: 'P',
        order_artwork: artwork_ids
    }, 'post');
}
;
opg.fn.goToRent = function(artwork_ids) {
    if (!$('#userBox').hasClass('logged_in')) {
        alert('작품을 렌탈하려면 먼저 로그인하셔야 합니다.');
        opg.fn.loginPopup();
        return;
    }
    if (Object.prototype.toString.call(artwork_ids) !== '[object Array]') {
        if (typeof artwork_ids === 'undefined') {
            artwork_ids = [];
        } else if (typeof artwork_ids === 'string') {
            artwork_ids = artwork_ids.split(',');
        } else {
            artwork_ids = [artwork_ids];
        }
    }
    post('/checkout/', {
        order_type: 'R',
        order_artwork: artwork_ids
    }, 'post');
}
;
opg.fn.kakao_init = false;
opg.fn.shareBox = function(button, ga_event_category) {
    var $button = $(button), shareBox, pathname, url, txt;
    function hide_shareBox(callback) {
        shareBox.fadeOut(100, function() {
            $document.unbind('.hide_shareBox');
            if (typeof callback === 'function') {
                callback();
            }
        });
    }
    function PopupCenter(url, title, w, h) {
        var dualScreenLeft = typeof window.screenLeft !== 'undefined' ? window.screenLeft : screen.left;
        var dualScreenTop = typeof window.screenTop !== 'undefined' ? window.screenTop : screen.top;
        var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
        var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;
        var left = (width - w) / 2 + dualScreenLeft;
        var top = (height - h) / 2 + dualScreenTop;
        var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
        if (window.focus) {
            newWindow.focus();
        }
    }
    ga_event_category = ga_event_category || '';
    if (!$button.length) {
        return;
    }
    if ($button.css('position') === 'static') {
        $button.css('position', 'relative');
    }
    if (!opg.fn.kakao_init && window.Kakao) {
        Kakao.init('839ec495f060a687df0e7b5eb0848f14');
        opg.fn.kakao_init = true;
    }
    pathname = $button.data('pathname') || location.pathname;
    url = location.origin + pathname;
    txt = $button.data('txt') || '';
    shareBox = $button.find('.shareBox');
    if (shareBox.length === 0) {
        shareBox = $('<div class="shareBox">' + '<h3 class="shareBox-head">' + '<span>공유하기</span>' + '<div class="shareBox-closeBtn"><i></i></div>' + '</h3>' + '<ul class="shareBox-body cf">' + '<li class="shareBox-li facebook"><i></i></li>' + '<li class="shareBox-li twitter"><i></i></li>' + '<li class="shareBox-li kakaostory"><i></i></li>' + '<li class="shareBox-li kakaotalk"><i></i></li>' + '<li class="shareBox-li naver"><i></i></li>' + '<li class="shareBox-li band"><i></i></li>' + '<li class="shareBox-li link"><i></i></li>' + '</ul>' + '<div class="shareBox-hiddenUrl">' + url + '</div>' + '</div>');
        shareBox.find('.shareBox-closeBtn').click(hide_shareBox);
        shareBox.find('.shareBox-li.facebook').click(function() {
            FB.ui({
                method: 'share',
                href: url,
                display: 'popup'
            }, function(response) {});
            hide_shareBox();
            dataLayer.push({
                event: ga_event_category,
                eventLabel: 'share_facebook'
            });
        });
        shareBox.find('.shareBox-li.twitter').click(function() {
            var intent_url = 'http://twitter.com/intent/tweet?text=' + encodeURIComponent(txt) + '&url=' + encodeURIComponent(url);
            PopupCenter(intent_url, 'share_twitter', 700, 420);
            hide_shareBox();
            dataLayer.push({
                event: ga_event_category,
                eventLabel: 'share_twitter'
            });
        });
        if (window.Kakao) {
            shareBox.find('.shareBox-li.kakaostory').click(function() {
                Kakao.Story.share({
                    url: url,
                    text: txt
                });
                hide_shareBox();
                dataLayer.push({
                    event: ga_event_category,
                    eventLabel: 'share_kakaostory'
                });
            });
            shareBox.find('.shareBox-li.kakaotalk').click(function() {
                Kakao.Link.sendScrap({
                    requestUrl: url
                });
                hide_shareBox();
                dataLayer.push({
                    event: ga_event_category,
                    eventLabel: 'share_kakaotalk'
                });
            });
        }
        shareBox.find('.shareBox-li.naver').click(function() {
            var intent_url = 'http://share.naver.com/web/shareView.nhn?url=' + encodeURI(encodeURIComponent(url)) + '&title=' + encodeURI(encodeURIComponent(txt));
            PopupCenter(intent_url, 'share_naver', 410, 500);
            hide_shareBox();
            dataLayer.push({
                event: ga_event_category,
                eventLabel: 'share_naver'
            });
        });
        shareBox.find('.shareBox-li.band').click(function() {
            var params = {
                text: encodeURIComponent(txt + '\n' + url).replace(/\+/g, '%20'),
                route: location.hostname
            };
            if (navigator.userAgent.match(/(iPhone|iPod|iPad|Android)/i)) {
                var service = {
                    schemeUrl: 'bandapp://create/post?text=' + params.text + '&route=' + params.route,
                    installUrlForIos: 'itms-apps://itunes.apple.com/app/id542613198',
                    installUrlForAndroid: 'market://details?id=com.nhn.android.band',
                    packageNameForAndroid: 'com.nhn.android.band',
                    webUrlForNotSupported: 'http://band.us'
                };
                var visited = (new Date()).getTime();
                if (navigator.userAgent.match(/iPhone|iPad|iPod/i)) {
                    function clearTimer(timer) {
                        return function() {
                            clearTimeout(timer);
                            window.removeEventListener('pagehide', arguments.callee);
                        }
                        ;
                    }
                    var timer = setTimeout(function() {
                        var now = (new Date()).getTime();
                        if (now - visited < 3000) {
                            window.location.href = service.installUrlForIos;
                        }
                    }, 2000);
                    window.addEventListener('pagehide', clearTimer(timer));
                    window.location.href = service.schemeUrl;
                } else if (navigator.userAgent.match(/Android/i)) {
                    var alreadyMoved = false;
                    var chromeString = navigator.userAgent.match(/Chrome\/[0-9]*/g);
                    if (chromeString && chromeString[0].split('/')[1] >= 25) {
                        window.location.href = "intent:" + service.schemeUrl + "#Intent;package=" + service.packageNameForAndroid + ";end;";
                    } else {
                        var iframe = document.createElement('iframe');
                        iframe.style.display = 'none';
                        iframe.src = service.schemeUrl;
                        setTimeout(function() {
                            if ((new Date()).getTime() - visited < 2000) {
                                if (!alreadyMoved) {
                                    alreadyMoved = true;
                                    window.location = service.installUrlForAndroid;
                                }
                            }
                        }, 500);
                        iframe.onload = function() {
                            if (!alreadyMoved) {
                                alreadyMoved = true;
                                window.location = service.installUrlForAndroid;
                            }
                        }
                        ;
                        document.body.appendChild(iframe);
                        document.body.removeChild(iframe);
                    }
                } else {
                    window.location.href = service.webUrlForNotSupported;
                }
            } else {
                PopupCenter('http://band.us/plugin/share?body=' + params.text + '&route=' + params.route, 'share_band', 600, 700);
            }
            hide_shareBox();
            dataLayer.push({
                event: ga_event_category,
                eventLabel: 'share_band'
            });
        });
        shareBox.find('.shareBox-li.link').click(function() {
            function l() {
                if (!document.queryCommandSupported || !document.queryCommandSupported('copy')) {
                    return false;
                }
                var result = false
                  , u = document.createRange()
                  , t = window.getSelection()
                  , onselectstart = document.body.onselectstart;
                document.body.onselectstart = null;
                u.selectNodeContents(shareBox.find('.shareBox-hiddenUrl')[0]);
                t.removeAllRanges();
                t.addRange(u);
                try {
                    result = document.execCommand('copy');
                } catch (err) {}
                if (window.getSelection().getRangeAt(0).getClientRects().length > 0) {
                    window.getSelection().removeAllRanges();
                }
                document.body.onselectstart = onselectstart;
                return result;
            }
            if (navigator.userAgent.toLowerCase().indexOf("gecko") !== -1) {
                if (!l()) {
                    hide_shareBox();
                    prompt('아래의 URL을 복사(Ctrl+C)하여\n원하는 곳에 붙여넣기(Ctrl+V)하세요.', url);
                    return;
                }
            } else {
                window.clipboardData.setData("Text", url);
            }
            $('<div class="shareBox-messageBox">주소가 복사되었습니다.<br/>원하시는 곳에<br/>붙여넣기(Ctrl+V) 해주세요.</div>').hide().appendTo(shareBox).fadeIn(100, function() {
                var $messageBox = $(this);
                setTimeout(function() {
                    hide_shareBox(function() {
                        $messageBox.remove();
                    });
                }, 1200);
            });
            dataLayer.push({
                event: ga_event_category,
                eventLabel: 'share_urlcopy'
            });
        });
        shareBox.click(function(e) {
            e.stopPropagation();
        }).appendTo($button);
    }
    shareBox.hide().fadeIn(100, function() {
        $document.one('click.hide_shareBox', hide_shareBox);
    });
    dataLayer.push({
        event: ga_event_category,
        eventLabel: 'share'
    });
}
;
opg.fn.getCookie = function(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) === ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) === 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}
;
opg.fn.setCookie = function(cname, cvalue, exdays) {
    var d = new Date();
    if (exdays === 'five_minutes') {
        d.setTime(d.getTime() + (5 * 60 * 1000));
    } else {
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    }
    var expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}
;
opg.fn.warehousingNoti = function($elem, artwork_code) {
    var $awdFbWarehousingNoti = $elem.find('.awd-fb-warehousingnoti')
      , $sectionStep1 = $awdFbWarehousingNoti.find('.warehousing_step1')
      , $sectionStep2 = $awdFbWarehousingNoti.find('.warehousing_step2')
      , $requestBtn = $awdFbWarehousingNoti.find('.awd-fb-btn-black')
      , $requestVerificationBtn = $awdFbWarehousingNoti.find('.request_verification_btn')
      , $reRequestVerificationBtn = $awdFbWarehousingNoti.find('.certified_phone_change_btn')
      , $certified_phone_div = $awdFbWarehousingNoti.find('.certified_phone');
    $elem.find('.warehousingNotiBtn').click(function(e) {
        if (!$('#userBox').hasClass('logged_in')) {
            alert('입고알림을 신청하려면 먼저 로그인하셔야 합니다.');
            opg.fn.loginPopup();
            return false;
        }
        $.ajax({
            url: '/warehousing_noti_detail/',
            type: 'POST',
            data: {
                artwork_code: artwork_code
            },
            dataType: 'json',
            success: function(jsonRsp) {
                if (jsonRsp.success) {
                    if (!jsonRsp.item) {
                        if ($awdFbWarehousingNoti.data('phone')) {
                            $sectionStep1.css('display', 'none');
                            $sectionStep2.css('display', 'block');
                            $requestBtn.removeClass('awd-fb-btn-disabled');
                        } else {
                            $sectionStep2.css('display', 'none');
                            $sectionStep1.css('display', 'block');
                            $requestBtn.addClass('awd-fb-btn-disabled');
                        }
                        $awdFbWarehousingNoti.addClass('awd-fb-show');
                    } else {
                        alert('이미 입고알림을 신청하신 작품입니다.');
                        e.preventDefault();
                    }
                } else {
                    alert('입고알림 신청 중 오류가 발생했습니다.\n바르지 않은 동작이 감지되었거나 세션이 만료되었을 수 있습니다. 새로고침 후 재시도 바랍니다.');
                    e.preventDefault();
                }
            },
            error: function() {
                alert('입고알림 신청 중 오류가 발생했습니다.\n바르지 않은 동작이 감지되었거나 세션이 만료되었을 수 있습니다. 새로고침 후 재시도 바랍니다.');
                e.preventDefault();
            }
        });
    });
    $awdFbWarehousingNoti.find('input[type=tel]').keypress(function(e) {
        if (!(48 <= e.which && e.which <= 57)) {
            e.preventDefault();
        }
    });
    $awdFbWarehousingNoti.find('.collapse-link').click(function() {
        var $parent = $(this).parent().parent();
        if ($parent.hasClass('fold')) {
            $parent.removeClass('fold');
            $parent.addClass('unfold');
        } else {
            $parent.removeClass('unfold');
            $parent.addClass('fold');
        }
    });
    $awdFbWarehousingNoti.find(".awd-fb-period").change(function() {
        $awdFbWarehousingNoti.find(".awd-fb-period").each(function() {
            $(this).parent().removeClass('checked');
        });
        if ($(this).is(':checked')) {
            $(this).parent().addClass('checked');
        }
    });
    $awdFbWarehousingNoti.find(".awd-fb-close").click(function() {
        $awdFbWarehousingNoti.removeClass('awd-fb-show');
    });
    $requestVerificationBtn.add($reRequestVerificationBtn).click(function() {
        IMP.init('imp81939184');
        IMP.certification({
            merchant_uid: 'cert_' + new Date().getTime() + '_' + Math.random().toString(36).substring(2, 15)
        }, function(rsp) {
            if (rsp.success) {
                $.ajax({
                    type: 'POST',
                    url: '/certification/',
                    dataType: 'json',
                    data: {
                        imp_uid: rsp.imp_uid,
                        save_user: '1'
                    }
                }).done(function(rsp) {
                    if (rsp.success) {
                        var data = rsp.data;
                        $sectionStep1.css('display', 'none');
                        $sectionStep2.css('display', 'block');
                        $requestBtn.removeClass('awd-fb-btn-disabled');
                        $certified_phone_div.text(data.phone);
                        $awdFbWarehousingNoti.data('phone', data.phone);
                    } else if (rsp.reason === 'not_logged_in') {
                        alert('로그인 세션이 만료되었습니다. 새로고침 또는 로그인 후 다시 시도해주세요.');
                    } else if (rsp.reason === 'key_does_not_match') {
                        alert('입력하신 정보가 회원정보와 일치하지 않습니다.\n휴대폰 번호 변경은 본인명의의 휴대폰으로만 가능합니다.');
                    } else if (rsp.reason === 'already_exists') {
                        alert('다른 계정에서 이미 본인인증 하셨습니다.\n아이디(이메일): ' + rsp.email);
                    } else {
                        alert('본인인증 정보를 가져오는 데 실패하였습니다. 다시 본인인증을 시도해주세요.');
                    }
                }).error(function() {
                    alert('서버 에러: 본인인증 정보를 가져오는 데 실패하였습니다.');
                });
            } else {
                alert('본인인증에 실패하였습니다: ' + rsp.error_msg);
            }
        });
    });
    $requestBtn.click(function(e) {
        if ($requestBtn.hasClass('awd-fb-btn-disabled')) {
            e.preventDefault();
            return;
        }
        if ($requestBtn.hasClass('wait')) {
            alert('요청중입니다. 잠시만 기다려 주세요.');
            e.preventDefault();
            return;
        }
        $requestBtn.addClass('wait');
        $.ajax({
            url: '/artwork/' + artwork_code + '/request_warehousing_alarm/complete/',
            type: 'POST',
            cache: false,
            data: {
                period: $awdFbWarehousingNoti.find("input[name=period]:checked").val()
            },
            dataType: 'json',
            async: false,
            success: function(jsonRsp) {
                if (jsonRsp.success) {
                    alert('입고알림 신청이 완료되었습니다.');
                    $awdFbWarehousingNoti.find(".awd-fb-close").click();
                } else {
                    switch (jsonRsp.reason) {
                    case 'data_load_error':
                        alert('데이터를 불러오지 못했습니다.');
                        break;
                    default:
                        alert('입고알림 신청 중 오류가 발생했습니다.\n바르지 않은 동작이 감지되었거나 세션이 만료되었을 수 있습니다. 새로고침 후 재시도 바랍니다.');
                    }
                }
                $requestBtn.removeClass('wait');
            },
            error: function() {
                alert('입고알림 신청 중 오류가 발생했습니다.\n바르지 않은 동작이 감지되었거나 세션이 만료되었을 수 있습니다. 새로고침 후 재시도 바랍니다.');
                $requestBtn.removeClass('wait');
            }
        });
        dataLayer.push({
            event: 'detail_action',
            eventLabel: 'WarehousingNotiReg',
            artworkCode: artwork_code
        });
    });
}
;

opg.fn.event_select_viewinroom = function($elem, view_in_room_width, ratio) {
    var $viewinroompreviewCarousel = $elem.find('.artworkDetail-viewinroom-content .owl-carousel')
      , $viewinroomImgWrap = $elem.find('.artworkDetail-viewinroom-img-wrap')
      , $viewinroomCarousel = $viewinroomImgWrap.find('.owl-carousel')
      , $viewinroomImgArtwork = $elem.find('.artworkDetail-viewinroom-img-artwork')
      , $viewinroombackgroundColor = $elem.find('.artworkDetail-viewinroom-background-color')
      , $artworkDetailViewinroomTagSpace = $elem.find('.artworkDetail-viewinroom-tag_space')
      , $artworkDetailViewinroomTagColor = $elem.find('.artworkDetail-viewinroom-tag_color');
    $viewinroompreviewCarousel.on('initialized.owl.carousel', function() {
        $(this).find(".owl-item").eq(0).addClass("synced");
    });
    $viewinroomCarousel.on('changed.owl.carousel', function(event) {
        var current = event.item.index;
        $viewinroompreviewCarousel.find(".owl-item").removeClass("synced").eq(current).addClass("synced");
        center($viewinroompreviewCarousel, current);
        $('.current-item').text(current + 1);
        $('.max-items').text(event.item.count);
    });
    $viewinroomCarousel.owlCarousel({
        items: 1,
        lazyLoad: true,
        mouseDrag: false,
        touchDrag: false,
        dots: false
    });
    $viewinroomCarousel.find('.owl-stage').off('mousedown.owl.core selectstart.owl.core touchstart.owl.core touchcancel.owl.core');
    $viewinroompreviewCarousel.owlCarousel({
        responsive: {
            0: {
                items: 4
            },
            544: {
                items: 5
            },
            768: {
                items: 4
            }
        },
        nav: true,
        navText: ["", ""],
        margin: 12,
        dots: false,
        rewind: false
    });
    $viewinroompreviewCarousel.on("click", ".owl-item", function(e) {
        e.preventDefault();
        var index = $(this).index();
        $viewinroomCarousel.trigger("to.owl.carousel", [index, 0]);
        var space = $(this).find(".item-description").text();
        $artworkDetailViewinroomTagSpace.text(space);
    });
    function center(carousel, number) {
        var sync2visible = [];
        var items = [];
        carousel.find(".owl-item").each(function() {
            items.push($(this).index());
            if ($(this).is(".active")) {
                sync2visible.push($(this).index());
            }
        });
        var num = number;
        var found = false;
        for (var i in sync2visible) {
            if (num === sync2visible[i]) {
                var found = true;
            }
        }
        if (found === false) {
            if (num > sync2visible[sync2visible.length - 1]) {
                carousel.trigger("to.owl.carousel", [num - sync2visible.length + 2, 0]);
            } else {
                if (num - 1 === -1) {
                    num = 0;
                }
                carousel.trigger("to.owl.carousel", [num, 0]);
            }
        } else if (num === sync2visible[sync2visible.length - 1]) {
            if (num !== items[items.length - 1]) {
                carousel.trigger("to.owl.carousel", [sync2visible[1], 0]);
            }
        } else if (num === sync2visible[0]) {
            if (num !== 0) {
                num = num - 1;
            }
            carousel.trigger("to.owl.carousel", [num, 0]);
        }
    }
    function getTransform(el) {
        var transform_value = $(el).css('-webkit-transform') || ''
          , results = transform_value.match(/matrix(?:(3d)\(-?\d+\.?\d*(?:, -?\d+\.?\d*)*(?:, (-?\d+\.?\d*))(?:, (-?\d+\.?\d*))(?:, (-?\d+\.?\d*)), -?\d+\.?\d*\)|\(-?\d+\.?\d*(?:, -?\d+\.?\d*)*(?:, (-?\d+\.?\d*))(?:, (-?\d+\.?\d*))\))/)
        if (!results)
            return [0, 0, 0];
        if (results[1] == '3d')
            return results.slice(2, 5);
        results.push(0);
        return results.slice(5, 8);
    }
    var width = Math.floor($viewinroomImgWrap.width() * 0.003 * view_in_room_width);
    var height = Math.floor(width * ratio);
    $viewinroomImgArtwork.css({
        'width': width + 'px',
        'height': height + 'px',
        '-webkit-transform': 'translate(-50%,-50%)',
        '-ms-transform': 'translate(-50%,-50%)',
        'transform': 'translate(-50%,-50%)'
    });
    if ($viewinroomImgArtwork.length > 0) {
        $(window).resize(function() {
            width = Math.floor($viewinroomImgWrap.width() * 0.003 * view_in_room_width);
            height = Math.floor(width * ratio);
            $viewinroomImgArtwork.css({
                'width': width + 'px',
                'height': height + 'px'
            });
            var results = getTransform($viewinroomImgArtwork);
        });
    }
    function onDrag() {
        var results = getTransform($viewinroomImgArtwork);
    }
    function onDragEnd() {
        dataLayer.push({
            'event': 'detail_action',
            'eventLabel': 'view_in_room_drag'
        });
    }
    $('.artworkDetail-viewinroom-content .item').click(function(e) {
        dataLayer.push({
            'event': 'detail_action',
            'eventLabel': 'change_space_to_' + $(this.children[0]).attr('alt')
        });
    });
    $('.artworkDetail-viewinroom-choice .item').click(function(e) {
        dataLayer.push({
            'event': 'detail_action',
            'eventLabel': 'click_space: ' + $(this.children[0]).attr('alt')
        });
    });
    $('.artworkDetail-viewinroom-background-color').click(function(e) {
        dataLayer.push({
            'event': 'detail_action',
            'eventLabel': 'change_color_to_' + $(this).attr('data-class')
        });
    });
    if ($viewinroomImgArtwork.height() > 0) {
        Draggable.create($viewinroomImgArtwork, {
            throwProps: true,
            type: "x,y",
            onDrag: onDrag,
        })[0].addEventListener('dragend', onDragEnd);
    } else {
        $viewinroomImgArtwork.on('load', function() {
            Draggable.create($viewinroomImgArtwork, {
                throwProps: true,
                type: "x,y",
                onDrag: onDrag,
            })[0].addEventListener('dragend', onDragEnd);
        });
    }
    $viewinroombackgroundColor.on("click", function(e) {
        var color = $(this).data("color");
        $viewinroombackgroundColor.removeClass("synced");
        $(this).addClass("synced");
        $viewinroomCarousel.css("background", color);
        $artworkDetailViewinroomTagColor.html($(this).data("name") + "<span class='artworkDetail-viewinroom-tag-mark " + $(this).data("class") + "'></span>");
    });
    $elem.find('.artworkDetail-collectionBox').click(function() {
        var $this = $(this)
          , artwork_code = $this.data('code');
        if ($this.hasClass('collected')) {
            opg.fn.remove_from_collection('artwork', artwork_code, function() {
                $this.removeClass('collected');
            });
            dataLayer.push({
                event: 'detail_action',
                eventLabel: 'mycollection_delete',
                artworkCode: artwork_code
            });
        } else {
            opg.fn.add_to_collection('artwork', artwork_code, function() {
                $this.addClass('collected');
            });
            dataLayer.push({
                event: 'detail_action',
                eventLabel: 'mycollection_add',
                artworkCode: artwork_code
            });
        }
    });
    $elem.find('.artworkDetail-shareButton').click(function() {
        opg.fn.shareBox(this, 'detail_action');
    });
    if (document.URL.indexOf('sp') > -1) {
        var getUrlParameter = function getUrlParameter(sParam) {
            var sPageURL = decodeURIComponent(window.location.search.substring(1)), sURLVariables = sPageURL.split('&'), sParameterName, i;
            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');
                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : sParameterName[1];
                }
            }
        };
        var $space_item = $elem.find('.artworkDetail-viewinroom-content .item').parent();
        var sp = getUrlParameter('sp');
        $space_item.each(function() {
            if ($(this).children().data('evspace') === sp) {
                $(this).trigger('click');
            } else {
                $(this).removeClass('synced');
            }
        })
    }
}
;
;(function($, window, document, undefined) {
    function Owl(element, options) {
    	
    	/*console.log("$:"+$+"element.innerHTML:"+element.innerHTML+"element.text:"+element.text);*/
    	
        this.settings = null;
        this.options = $.extend({}, Owl.Defaults, options);
        this.$element = $(element);
        this._handlers = {};
        this._plugins = {};
        this._supress = {};
        this._current = null;
        this._speed = null;
        this._coordinates = [];
        this._breakpoint = null;
        this._width = null;
        this._items = [];
        this._clones = [];
        this._mergers = [];
        this._widths = [];
        this._invalidated = {};
        this._pipe = [];
        this._drag = {
            time: null,
            target: null,
            pointer: null,
            stage: {
                start: null,
                current: null
            },
            direction: null
        };
        this._states = {
            current: {},
            tags: {
                'initializing': ['busy'],
                'animating': ['busy'],
                'dragging': ['interacting']
            }
        };
        $.each(['onResize', 'onThrottledResize'], $.proxy(function(i, handler) {
            this._handlers[handler] = $.proxy(this[handler], this);
        }, this));
        $.each(Owl.Plugins, $.proxy(function(key, plugin) {
            this._plugins[key.charAt(0).toLowerCase() + key.slice(1)] = new plugin(this);
        }, this));
        $.each(Owl.Workers, $.proxy(function(priority, worker) {
            this._pipe.push({
                'filter': worker.filter,
                'run': $.proxy(worker.run, this)
            });
        }, this));
        this.setup();
        this.initialize();
    }
    Owl.Defaults = {
        items: 3,
        loop: false,
        center: false,
        rewind: false,
        checkVisibility: true,
        mouseDrag: true,
        touchDrag: true,
        pullDrag: true,
        freeDrag: false,
        margin: 0,
        stagePadding: 0,
        merge: false,
        mergeFit: true,
        autoWidth: false,
        startPosition: 0,
        rtl: false,
        smartSpeed: 250,
        fluidSpeed: false,
        dragEndSpeed: false,
        responsive: {},
        responsiveRefreshRate: 200,
        responsiveBaseElement: window,
        fallbackEasing: 'swing',
        slideTransition: '',
        info: false,
        nestedItemSelector: false,
        itemElement: 'div',
        stageElement: 'div',
        refreshClass: 'owl-refresh',
        loadedClass: 'owl-loaded',
        loadingClass: 'owl-loading',
        rtlClass: 'owl-rtl',
        responsiveClass: 'owl-responsive',
        dragClass: 'owl-drag',
        itemClass: 'owl-item',
        stageClass: 'owl-stage',
        stageOuterClass: 'owl-stage-outer',
        grabClass: 'owl-grab'
    };
    Owl.Width = {
        Default: 'default',
        Inner: 'inner',
        Outer: 'outer'
    };
    Owl.Type = {
        Event: 'event',
        State: 'state'
    };
    Owl.Plugins = {};
    Owl.Workers = [{
        filter: ['width', 'settings'],
        run: function() {
            this._width = this.$element.width();
        }
    }, {
        filter: ['width', 'items', 'settings'],
        run: function(cache) {
            cache.current = this._items && this._items[this.relative(this._current)];
        }
    }, {
        filter: ['items', 'settings'],
        run: function() {
            this.$stage.children('.cloned').remove();
        }
    }, {
        filter: ['width', 'items', 'settings'],
        run: function(cache) {
            var margin = this.settings.margin || ''
              , grid = !this.settings.autoWidth
              , rtl = this.settings.rtl
              , css = {
                'width': 'auto',
                'margin-left': rtl ? margin : '',
                'margin-right': rtl ? '' : margin
            };
            !grid && this.$stage.children().css(css);
            cache.css = css;
        }
    }, {
        filter: ['width', 'items', 'settings'],
        run: function(cache) {
            var width = (this.width() / this.settings.items).toFixed(3) - this.settings.margin
              , merge = null
              , iterator = this._items.length
              , grid = !this.settings.autoWidth
              , widths = [];
            cache.items = {
                merge: false,
                width: width
            };
            while (iterator--) {
                merge = this._mergers[iterator];
                merge = this.settings.mergeFit && Math.min(merge, this.settings.items) || merge;
                cache.items.merge = merge > 1 || cache.items.merge;
                widths[iterator] = !grid ? this._items[iterator].width() : width * merge;
            }
            this._widths = widths;
        }
    }, {
        filter: ['items', 'settings'],
        run: function() {
            var clones = []
              , items = this._items
              , settings = this.settings
              , view = Math.max(settings.items * 2, 4)
              , size = Math.ceil(items.length / 2) * 2
              , repeat = settings.loop && items.length ? settings.rewind ? view : Math.max(view, size) : 0
              , append = ''
              , prepend = '';
            repeat /= 2;
            while (repeat > 0) {
                clones.push(this.normalize(clones.length / 2, true));
                append = append + items[clones[clones.length - 1]][0].outerHTML;
                clones.push(this.normalize(items.length - 1 - (clones.length - 1) / 2, true));
                prepend = items[clones[clones.length - 1]][0].outerHTML + prepend;
                repeat -= 1;
            }
            this._clones = clones;
            $(append).addClass('cloned').appendTo(this.$stage);
            $(prepend).addClass('cloned').prependTo(this.$stage);
        }
    }, {
        filter: ['width', 'items', 'settings'],
        run: function() {
            var rtl = this.settings.rtl ? 1 : -1
              , size = this._clones.length + this._items.length
              , iterator = -1
              , previous = 0
              , current = 0
              , coordinates = [];
            while (++iterator < size) {
                previous = coordinates[iterator - 1] || 0;
                current = this._widths[this.relative(iterator)] + this.settings.margin;
                coordinates.push(previous + current * rtl);
            }
            this._coordinates = coordinates;
        }
    }, {
        filter: ['width', 'items', 'settings'],
        run: function() {
            var padding = this.settings.stagePadding
              , coordinates = this._coordinates
              , css = {
                'width': 2 * Math.ceil(Math.abs(coordinates[coordinates.length - 1])) + padding * 2,
                'padding-left': padding || '',
                'padding-right': padding || ''
            };
            this.$stage.css(css);
        }
    }, {
        filter: ['width', 'items', 'settings'],
        run: function(cache) {
            var iterator = this._coordinates.length
              , grid = !this.settings.autoWidth
              , items = this.$stage.children();
            if (grid && cache.items.merge) {
                while (iterator--) {
                    cache.css.width = this._widths[this.relative(iterator)];
                    items.eq(iterator).css(cache.css);
                }
            } else if (grid) {
                cache.css.width = cache.items.width;
                items.css(cache.css);
            }
        }
    }, {
        filter: ['items'],
        run: function() {
            this._coordinates.length < 1 && this.$stage.removeAttr('style');
        }
    }, {
        filter: ['width', 'items', 'settings'],
        run: function(cache) {
            cache.current = cache.current ? this.$stage.children().index(cache.current) : 0;
            cache.current = Math.max(this.minimum(), Math.min(this.maximum(), cache.current));
            this.reset(cache.current);
        }
    }, {
        filter: ['position'],
        run: function() {
            this.animate(this.coordinates(this._current));
        }
    }, {
        filter: ['width', 'position', 'items', 'settings'],
        run: function() {
            var rtl = this.settings.rtl ? 1 : -1, padding = this.settings.stagePadding * 2, begin = this.coordinates(this.current()) + padding, end = begin + this.width() * rtl, inner, outer, matches = [], i, n;
            for (i = 0,
            n = this._coordinates.length; i < n; i++) {
                inner = this._coordinates[i - 1] || 0;
                outer = Math.abs(this._coordinates[i]) + padding * rtl;
                if ((this.op(inner, '<=', begin) && (this.op(inner, '>', end))) || (this.op(outer, '<', begin) && this.op(outer, '>', end))) {
                    matches.push(i);
                }
            }
            this.$stage.children('.active').removeClass('active');
            this.$stage.children(':eq(' + matches.join('), :eq(') + ')').addClass('active');
            this.$stage.children('.center').removeClass('center');
            if (this.settings.center) {
                this.$stage.children().eq(this.current()).addClass('center');
            }
        }
    }];
    Owl.prototype.initializeStage = function() {
        this.$stage = this.$element.find('.' + this.settings.stageClass);
        if (this.$stage.length) {
            return;
        }
        this.$element.addClass(this.options.loadingClass);
        this.$stage = $('<' + this.settings.stageElement + '>', {
            "class": this.settings.stageClass
        }).wrap($('<div/>', {
            "class": this.settings.stageOuterClass
        }));
        this.$element.append(this.$stage.parent());
    }
    ;
    Owl.prototype.initializeItems = function() {
        var $items = this.$element.find('.owl-item');
        if ($items.length) {
            this._items = $items.get().map(function(item) {
                return $(item);
            });
            this._mergers = this._items.map(function() {
                return 1;
            });
            this.refresh();
            return;
        }
        this.replace(this.$element.children().not(this.$stage.parent()));
        if (this.isVisible()) {
            this.refresh();
        } else {
            this.invalidate('width');
        }
        this.$element.removeClass(this.options.loadingClass).addClass(this.options.loadedClass);
    }
    ;
    Owl.prototype.initialize = function() {
        this.enter('initializing');
        this.trigger('initialize');
        this.$element.toggleClass(this.settings.rtlClass, this.settings.rtl);
        if (this.settings.autoWidth && !this.is('pre-loading')) {
            var imgs, nestedSelector, width;
            imgs = this.$element.find('img');
            nestedSelector = this.settings.nestedItemSelector ? '.' + this.settings.nestedItemSelector : undefined;
            width = this.$element.children(nestedSelector).width();
            if (imgs.length && width <= 0) {
                this.preloadAutoWidthImages(imgs);
            }
        }
        this.initializeStage();
        this.initializeItems();
        this.registerEventHandlers();
        this.leave('initializing');
        this.trigger('initialized');
    }
    ;
    Owl.prototype.isVisible = function() {
        return this.settings.checkVisibility ? this.$element.is(':visible') : true;
    }
    ;
    Owl.prototype.setup = function() {
        var viewport = this.viewport()
          , overwrites = this.options.responsive
          , match = -1
          , settings = null;
        if (!overwrites) {
            settings = $.extend({}, this.options);
        } else {
            $.each(overwrites, function(breakpoint) {
                if (breakpoint <= viewport && breakpoint > match) {
                    match = Number(breakpoint);
                }
            });
            settings = $.extend({}, this.options, overwrites[match]);
            if (typeof settings.stagePadding === 'function') {
                settings.stagePadding = settings.stagePadding();
            }
            delete settings.responsive;
            if (settings.responsiveClass) {
                this.$element.attr('class', this.$element.attr('class').replace(new RegExp('(' + this.options.responsiveClass + '-)\\S+\\s','g'), '$1' + match));
            }
        }
        this.trigger('change', {
            property: {
                name: 'settings',
                value: settings
            }
        });
        this._breakpoint = match;
        this.settings = settings;
        this.invalidate('settings');
        this.trigger('changed', {
            property: {
                name: 'settings',
                value: this.settings
            }
        });
    }
    ;
    Owl.prototype.optionsLogic = function() {
        if (this.settings.autoWidth) {
            this.settings.stagePadding = false;
            this.settings.merge = false;
        }
    }
    ;
    Owl.prototype.prepare = function(item) {
        var event = this.trigger('prepare', {
            content: item
        });
        if (!event.data) {
            event.data = $('<' + this.settings.itemElement + '/>').addClass(this.options.itemClass).append(item)
        }
        this.trigger('prepared', {
            content: event.data
        });
        return event.data;
    }
    ;
    Owl.prototype.update = function() {
        var i = 0
          , n = this._pipe.length
          , filter = $.proxy(function(p) {
            return this[p]
        }, this._invalidated)
          , cache = {};
        while (i < n) {
            if (this._invalidated.all || $.grep(this._pipe[i].filter, filter).length > 0) {
                this._pipe[i].run(cache);
            }
            i++;
        }
        this._invalidated = {};
        !this.is('valid') && this.enter('valid');
    }
    ;
    Owl.prototype.width = function(dimension) {
        dimension = dimension || Owl.Width.Default;
        switch (dimension) {
        case Owl.Width.Inner:
        case Owl.Width.Outer:
            return this._width;
        default:
            return this._width - this.settings.stagePadding * 2 + this.settings.margin;
        }
    }
    ;
    Owl.prototype.refresh = function() {
        this.enter('refreshing');
        this.trigger('refresh');
        this.setup();
        this.optionsLogic();
        this.$element.addClass(this.options.refreshClass);
        this.update();
        this.$element.removeClass(this.options.refreshClass);
        this.leave('refreshing');
        this.trigger('refreshed');
    }
    ;
    Owl.prototype.onThrottledResize = function() {
        window.clearTimeout(this.resizeTimer);
        this.resizeTimer = window.setTimeout(this._handlers.onResize, this.settings.responsiveRefreshRate);
    }
    ;
    Owl.prototype.onResize = function() {
        if (!this._items.length) {
            return false;
        }
        if (this._width === this.$element.width()) {
            return false;
        }
        if (!this.isVisible()) {
            return false;
        }
        this.enter('resizing');
        if (this.trigger('resize').isDefaultPrevented()) {
            this.leave('resizing');
            return false;
        }
        this.invalidate('width');
        this.refresh();
        this.registerEventHandlers();
        this.leave('resizing');
        this.trigger('resized');
    }
    ;
    Owl.prototype.registerEventHandlers = function() {
        if ($.support.transition) {
            this.$stage.on($.support.transition.end + '.owl.core', $.proxy(this.onTransitionEnd, this));
        }
        if (this.settings.responsive !== false) {
            this.on(window, 'resize', this._handlers.onThrottledResize);
        }
        if (this.settings.mouseDrag) {
            this.$element.addClass(this.options.dragClass);
            this.$stage.on('mousedown.owl.core', $.proxy(this.onDragStart, this));
            this.$stage.on('dragstart.owl.core selectstart.owl.core', function() {
                return false
            });
        } else {
            this.$element.removeClass(this.options.dragClass);
            this.$stage.off('mousedown.owl.core selectstart.owl.core');
        }
        if (this.settings.touchDrag) {
            this.$stage.on('touchstart.owl.core', $.proxy(this.onDragStart, this));
            this.$stage.on('touchcancel.owl.core', $.proxy(this.onDragEnd, this));
        } else {
            this.$stage.off('touchstart.owl.core touchcancel.owl.core');
        }
    }
    ;
    Owl.prototype.onDragStart = function(event) {
        var stage = null;
        if (event.which === 3) {
            return;
        }
        if ($.support.transform) {
            stage = this.$stage.css('transform').replace(/.*\(|\)| /g, '').split(',');
            stage = {
                x: stage[stage.length === 16 ? 12 : 4],
                y: stage[stage.length === 16 ? 13 : 5]
            };
        } else {
            stage = this.$stage.position();
            stage = {
                x: this.settings.rtl ? stage.left + this.$stage.width() - this.width() + this.settings.margin : stage.left,
                y: stage.top
            };
        }
        if (this.is('animating')) {
            $.support.transform ? this.animate(stage.x) : this.$stage.stop()
            this.invalidate('position');
        }
        this.$element.toggleClass(this.options.grabClass, event.type === 'mousedown');
        this.speed(0);
        this._drag.time = new Date().getTime();
        this._drag.target = $(event.target);
        this._drag.stage.start = stage;
        this._drag.stage.current = stage;
        this._drag.pointer = this.pointer(event);
        $(document).on('mouseup.owl.core touchend.owl.core', $.proxy(this.onDragEnd, this));
        $(document).one('mousemove.owl.core touchmove.owl.core', $.proxy(function(event) {
            var delta = this.difference(this._drag.pointer, this.pointer(event));
            $(document).on('mousemove.owl.core touchmove.owl.core', $.proxy(this.onDragMove, this));
            if (Math.abs(delta.x) < Math.abs(delta.y) && this.is('valid')) {
                return;
            }
            event.preventDefault();
            this.enter('dragging');
            this.trigger('drag');
        }, this));
    }
    ;
    Owl.prototype.onDragMove = function(event) {
        var minimum = null
          , maximum = null
          , pull = null
          , delta = this.difference(this._drag.pointer, this.pointer(event))
          , stage = this.difference(this._drag.stage.start, delta);
        if (!this.is('dragging')) {
            return;
        }
        event.preventDefault();
        if (this.settings.loop) {
            minimum = this.coordinates(this.minimum());
            maximum = this.coordinates(this.maximum() + 1) - minimum;
            stage.x = (((stage.x - minimum) % maximum + maximum) % maximum) + minimum;
        } else {
            minimum = this.settings.rtl ? this.coordinates(this.maximum()) : this.coordinates(this.minimum());
            maximum = this.settings.rtl ? this.coordinates(this.minimum()) : this.coordinates(this.maximum());
            pull = this.settings.pullDrag ? -1 * delta.x / 5 : 0;
            stage.x = Math.max(Math.min(stage.x, minimum + pull), maximum + pull);
        }
        this._drag.stage.current = stage;
        this.animate(stage.x);
    }
    ;
    Owl.prototype.onDragEnd = function(event) {
        var delta = this.difference(this._drag.pointer, this.pointer(event))
          , stage = this._drag.stage.current
          , direction = delta.x > 0 ^ this.settings.rtl ? 'left' : 'right';
        $(document).off('.owl.core');
        this.$element.removeClass(this.options.grabClass);
        if (delta.x !== 0 && this.is('dragging') || !this.is('valid')) {
            this.speed(this.settings.dragEndSpeed || this.settings.smartSpeed);
            this.current(this.closest(stage.x, delta.x !== 0 ? direction : this._drag.direction));
            this.invalidate('position');
            this.update();
            this._drag.direction = direction;
            if (Math.abs(delta.x) > 3 || new Date().getTime() - this._drag.time > 300) {
                this._drag.target.one('click.owl.core', function() {
                    return false;
                });
            }
        }
        if (!this.is('dragging')) {
            return;
        }
        this.leave('dragging');
        this.trigger('dragged');
    }
    ;
    Owl.prototype.closest = function(coordinate, direction) {
        var position = -1
          , pull = 30
          , width = this.width()
          , coordinates = this.coordinates();
        if (!this.settings.freeDrag) {
            $.each(coordinates, $.proxy(function(index, value) {
                if (direction === 'left' && coordinate > value - pull && coordinate < value + pull) {
                    position = index;
                } else if (direction === 'right' && coordinate > value - width - pull && coordinate < value - width + pull) {
                    position = index + 1;
                } else if (this.op(coordinate, '<', value) && this.op(coordinate, '>', coordinates[index + 1] !== undefined ? coordinates[index + 1] : value - width)) {
                    position = direction === 'left' ? index + 1 : index;
                }
                return position === -1;
            }, this));
        }
        if (!this.settings.loop) {
            if (this.op(coordinate, '>', coordinates[this.minimum()])) {
                position = coordinate = this.minimum();
            } else if (this.op(coordinate, '<', coordinates[this.maximum()])) {
                position = coordinate = this.maximum();
            }
        }
        return position;
    }
    ;
    Owl.prototype.animate = function(coordinate) {
        var animate = this.speed() > 0;
        this.is('animating') && this.onTransitionEnd();
        if (animate) {
            this.enter('animating');
            this.trigger('translate');
        }
        if ($.support.transform3d && $.support.transition) {
            this.$stage.css({
                transform: 'translate3d(' + coordinate + 'px,0px,0px)',
                transition: (this.speed() / 1000) + 's' + (this.settings.slideTransition ? ' ' + this.settings.slideTransition : '')
            });
        } else if (animate) {
            this.$stage.animate({
                left: coordinate + 'px'
            }, this.speed(), this.settings.fallbackEasing, $.proxy(this.onTransitionEnd, this));
        } else {
            this.$stage.css({
                left: coordinate + 'px'
            });
        }
    }
    ;
    Owl.prototype.is = function(state) {
        return this._states.current[state] && this._states.current[state] > 0;
    }
    ;
    Owl.prototype.current = function(position) {
        if (position === undefined) {
            return this._current;
        }
        if (this._items.length === 0) {
            return undefined;
        }
        position = this.normalize(position);
        if (this._current !== position) {
            var event = this.trigger('change', {
                property: {
                    name: 'position',
                    value: position
                }
            });
            if (event.data !== undefined) {
                position = this.normalize(event.data);
            }
            this._current = position;
            this.invalidate('position');
            this.trigger('changed', {
                property: {
                    name: 'position',
                    value: this._current
                }
            });
        }
        return this._current;
    }
    ;
    Owl.prototype.invalidate = function(part) {
        if ($.type(part) === 'string') {
            this._invalidated[part] = true;
            this.is('valid') && this.leave('valid');
        }
        return $.map(this._invalidated, function(v, i) {
            return i
        });
    }
    ;
    Owl.prototype.reset = function(position) {
        position = this.normalize(position);
        if (position === undefined) {
            return;
        }
        this._speed = 0;
        this._current = position;
        this.suppress(['translate', 'translated']);
        this.animate(this.coordinates(position));
        this.release(['translate', 'translated']);
    }
    ;
    Owl.prototype.normalize = function(position, relative) {
        var n = this._items.length
          , m = relative ? 0 : this._clones.length;
        if (!this.isNumeric(position) || n < 1) {
            position = undefined;
        } else if (position < 0 || position >= n + m) {
            position = ((position - m / 2) % n + n) % n + m / 2;
        }
        return position;
    }
    ;
    Owl.prototype.relative = function(position) {
        position -= this._clones.length / 2;
        return this.normalize(position, true);
    }
    ;
    Owl.prototype.maximum = function(relative) {
        var settings = this.settings, maximum = this._coordinates.length, iterator, reciprocalItemsWidth, elementWidth;
        if (settings.loop) {
            maximum = this._clones.length / 2 + this._items.length - 1;
        } else if (settings.autoWidth || settings.merge) {
            iterator = this._items.length;
            if (iterator) {
                reciprocalItemsWidth = this._items[--iterator].width();
                elementWidth = this.$element.width();
                while (iterator--) {
                    reciprocalItemsWidth += this._items[iterator].width() + this.settings.margin;
                    if (reciprocalItemsWidth > elementWidth) {
                        break;
                    }
                }
            }
            maximum = iterator + 1;
        } else if (settings.center) {
            maximum = this._items.length - 1;
        } else {
            maximum = this._items.length - settings.items;
        }
        if (relative) {
            maximum -= this._clones.length / 2;
        }
        return Math.max(maximum, 0);
    }
    ;
    Owl.prototype.minimum = function(relative) {
        return relative ? 0 : this._clones.length / 2;
    }
    ;
    Owl.prototype.items = function(position) {
        if (position === undefined) {
            return this._items.slice();
        }
        position = this.normalize(position, true);
        return this._items[position];
    }
    ;
    Owl.prototype.mergers = function(position) {
        if (position === undefined) {
            return this._mergers.slice();
        }
        position = this.normalize(position, true);
        return this._mergers[position];
    }
    ;
    Owl.prototype.clones = function(position) {
        var odd = this._clones.length / 2
          , even = odd + this._items.length
          , map = function(index) {
            return index % 2 === 0 ? even + index / 2 : odd - (index + 1) / 2
        };
        if (position === undefined) {
            return $.map(this._clones, function(v, i) {
                return map(i)
            });
        }
        return $.map(this._clones, function(v, i) {
            return v === position ? map(i) : null
        });
    }
    ;
    Owl.prototype.speed = function(speed) {
        if (speed !== undefined) {
            this._speed = speed;
        }
        return this._speed;
    }
    ;
    Owl.prototype.coordinates = function(position) {
        var multiplier = 1, newPosition = position - 1, coordinate;
        if (position === undefined) {
            return $.map(this._coordinates, $.proxy(function(coordinate, index) {
                return this.coordinates(index);
            }, this));
        }
        if (this.settings.center) {
            if (this.settings.rtl) {
                multiplier = -1;
                newPosition = position + 1;
            }
            coordinate = this._coordinates[position];
            coordinate += (this.width() - coordinate + (this._coordinates[newPosition] || 0)) / 2 * multiplier;
        } else {
            coordinate = this._coordinates[newPosition] || 0;
        }
        coordinate = Math.ceil(coordinate);
        return coordinate;
    }
    ;
    Owl.prototype.duration = function(from, to, factor) {
        if (factor === 0) {
            return 0;
        }
        return Math.min(Math.max(Math.abs(to - from), 1), 6) * Math.abs((factor || this.settings.smartSpeed));
    }
    ;
    Owl.prototype.to = function(position, speed) {
        var current = this.current()
          , revert = null
          , distance = position - this.relative(current)
          , direction = (distance > 0) - (distance < 0)
          , items = this._items.length
          , minimum = this.minimum()
          , maximum = this.maximum();
        if (this.settings.loop) {
            if (!this.settings.rewind && Math.abs(distance) > items / 2) {
                distance += direction * -1 * items;
            }
            position = current + distance;
            revert = ((position - minimum) % items + items) % items + minimum;
            if (revert !== position && revert - distance <= maximum && revert - distance > 0) {
                current = revert - distance;
                position = revert;
                this.reset(current);
            }
        } else if (this.settings.rewind) {
            maximum += 1;
            position = (position % maximum + maximum) % maximum;
        } else {
            position = Math.max(minimum, Math.min(maximum, position));
        }
        this.speed(this.duration(current, position, speed));
        this.current(position);
        if (this.isVisible()) {
            this.update();
        }
    }
    ;
    Owl.prototype.next = function(speed) {
        speed = speed || false;
        this.to(this.relative(this.current()) + 1, speed);
    }
    ;
    Owl.prototype.prev = function(speed) {
        speed = speed || false;
        this.to(this.relative(this.current()) - 1, speed);
    }
    ;
    Owl.prototype.onTransitionEnd = function(event) {
        if (event !== undefined) {
            event.stopPropagation();
            if ((event.target || event.srcElement || event.originalTarget) !== this.$stage.get(0)) {
                return false;
            }
        }
        this.leave('animating');
        this.trigger('translated');
    }
    ;
    Owl.prototype.viewport = function() {
        var width;
        if (this.options.responsiveBaseElement !== window) {
            width = $(this.options.responsiveBaseElement).width();
        } else if (window.innerWidth) {
            width = window.innerWidth;
        } else if (document.documentElement && document.documentElement.clientWidth) {
            width = document.documentElement.clientWidth;
        } else {
            console.warn('Can not detect viewport width.');
        }
        return width;
    }
    ;
    Owl.prototype.replace = function(content) {
        this.$stage.empty();
        this._items = [];
        if (content) {
            content = (content instanceof jQuery) ? content : $(content);
        }
        if (this.settings.nestedItemSelector) {
            content = content.find('.' + this.settings.nestedItemSelector);
        }
        content.filter(function() {
            return this.nodeType === 1;
        }).each($.proxy(function(index, item) {
            item = this.prepare(item);
            this.$stage.append(item);
            this._items.push(item);
            this._mergers.push(item.find('[data-merge]').addBack('[data-merge]').attr('data-merge') * 1 || 1);
        }, this));
        this.reset(this.isNumeric(this.settings.startPosition) ? this.settings.startPosition : 0);
        this.invalidate('items');
    }
    ;
    Owl.prototype.add = function(content, position) {
        var current = this.relative(this._current);
        position = position === undefined ? this._items.length : this.normalize(position, true);
        content = content instanceof jQuery ? content : $(content);
        this.trigger('add', {
            content: content,
            position: position
        });
        content = this.prepare(content);
        if (this._items.length === 0 || position === this._items.length) {
            this._items.length === 0 && this.$stage.append(content);
            this._items.length !== 0 && this._items[position - 1].after(content);
            this._items.push(content);
            this._mergers.push(content.find('[data-merge]').addBack('[data-merge]').attr('data-merge') * 1 || 1);
        } else {
            this._items[position].before(content);
            this._items.splice(position, 0, content);
            this._mergers.splice(position, 0, content.find('[data-merge]').addBack('[data-merge]').attr('data-merge') * 1 || 1);
        }
        this._items[current] && this.reset(this._items[current].index());
        this.invalidate('items');
        this.trigger('added', {
            content: content,
            position: position
        });
    }
    ;
    Owl.prototype.remove = function(position) {
        position = this.normalize(position, true);
        if (position === undefined) {
            return;
        }
        this.trigger('remove', {
            content: this._items[position],
            position: position
        });
        this._items[position].remove();
        this._items.splice(position, 1);
        this._mergers.splice(position, 1);
        this.invalidate('items');
        this.trigger('removed', {
            content: null,
            position: position
        });
    }
    ;
    Owl.prototype.preloadAutoWidthImages = function(images) {
        images.each($.proxy(function(i, element) {
            this.enter('pre-loading');
            element = $(element);
            $(new Image()).one('load', $.proxy(function(e) {
                element.attr('src', e.target.src);
                element.css('opacity', 1);
                this.leave('pre-loading');
                !this.is('pre-loading') && !this.is('initializing') && this.refresh();
            }, this)).attr('src', element.attr('src') || element.attr('data-src') || element.attr('data-src-retina'));
        }, this));
    }
    ;
    Owl.prototype.destroy = function() {
        this.$element.off('.owl.core');
        this.$stage.off('.owl.core');
        $(document).off('.owl.core');
        if (this.settings.responsive !== false) {
            window.clearTimeout(this.resizeTimer);
            this.off(window, 'resize', this._handlers.onThrottledResize);
        }
        for (var i in this._plugins) {
            this._plugins[i].destroy();
        }
        this.$stage.children('.cloned').remove();
        this.$stage.unwrap();
        this.$stage.children().contents().unwrap();
        this.$stage.children().unwrap();
        this.$stage.remove();
        this.$element.removeClass(this.options.refreshClass).removeClass(this.options.loadingClass).removeClass(this.options.loadedClass).removeClass(this.options.rtlClass).removeClass(this.options.dragClass).removeClass(this.options.grabClass).attr('class', this.$element.attr('class').replace(new RegExp(this.options.responsiveClass + '-\\S+\\s','g'), '')).removeData('owl.carousel');
    }
    ;
    Owl.prototype.op = function(a, o, b) {
        var rtl = this.settings.rtl;
        switch (o) {
        case '<':
            return rtl ? a > b : a < b;
        case '>':
            return rtl ? a < b : a > b;
        case '>=':
            return rtl ? a <= b : a >= b;
        case '<=':
            return rtl ? a >= b : a <= b;
        default:
            break;
        }
    }
    ;
    Owl.prototype.on = function(element, event, listener, capture) {
        if (element.addEventListener) {
            element.addEventListener(event, listener, capture);
        } else if (element.attachEvent) {
            element.attachEvent('on' + event, listener);
        }
    }
    ;
    Owl.prototype.off = function(element, event, listener, capture) {
        if (element.removeEventListener) {
            element.removeEventListener(event, listener, capture);
        } else if (element.detachEvent) {
            element.detachEvent('on' + event, listener);
        }
    }
    ;
    Owl.prototype.trigger = function(name, data, namespace, state, enter) {
        var status = {
            item: {
                count: this._items.length,
                index: this.current()
            }
        }
          , handler = $.camelCase($.grep(['on', name, namespace], function(v) {
            return v
        }).join('-').toLowerCase())
          , event = $.Event([name, 'owl', namespace || 'carousel'].join('.').toLowerCase(), $.extend({
            relatedTarget: this
        }, status, data));
        if (!this._supress[name]) {
            $.each(this._plugins, function(name, plugin) {
                if (plugin.onTrigger) {
                    plugin.onTrigger(event);
                }
            });
            this.register({
                type: Owl.Type.Event,
                name: name
            });
            this.$element.trigger(event);
            if (this.settings && typeof this.settings[handler] === 'function') {
                this.settings[handler].call(this, event);
            }
        }
        return event;
    }
    ;
    Owl.prototype.enter = function(name) {
        $.each([name].concat(this._states.tags[name] || []), $.proxy(function(i, name) {
            if (this._states.current[name] === undefined) {
                this._states.current[name] = 0;
            }
            this._states.current[name]++;
        }, this));
    }
    ;
    Owl.prototype.leave = function(name) {
        $.each([name].concat(this._states.tags[name] || []), $.proxy(function(i, name) {
            this._states.current[name]--;
        }, this));
    }
    ;
    Owl.prototype.register = function(object) {
        if (object.type === Owl.Type.Event) {
            if (!$.event.special[object.name]) {
                $.event.special[object.name] = {};
            }
            if (!$.event.special[object.name].owl) {
                var _default = $.event.special[object.name]._default;
                $.event.special[object.name]._default = function(e) {
                    if (_default && _default.apply && (!e.namespace || e.namespace.indexOf('owl') === -1)) {
                        return _default.apply(this, arguments);
                    }
                    return e.namespace && e.namespace.indexOf('owl') > -1;
                }
                ;
                $.event.special[object.name].owl = true;
            }
        } else if (object.type === Owl.Type.State) {
            if (!this._states.tags[object.name]) {
                this._states.tags[object.name] = object.tags;
            } else {
                this._states.tags[object.name] = this._states.tags[object.name].concat(object.tags);
            }
            this._states.tags[object.name] = $.grep(this._states.tags[object.name], $.proxy(function(tag, i) {
                return $.inArray(tag, this._states.tags[object.name]) === i;
            }, this));
        }
    }
    ;
    Owl.prototype.suppress = function(events) {
        $.each(events, $.proxy(function(index, event) {
            this._supress[event] = true;
        }, this));
    }
    ;
    Owl.prototype.release = function(events) {
        $.each(events, $.proxy(function(index, event) {
            delete this._supress[event];
        }, this));
    }
    ;
    Owl.prototype.pointer = function(event) {
        var result = {
            x: null,
            y: null
        };
        event = event.originalEvent || event || window.event;
        event = event.touches && event.touches.length ? event.touches[0] : event.changedTouches && event.changedTouches.length ? event.changedTouches[0] : event;
        if (event.pageX) {
            result.x = event.pageX;
            result.y = event.pageY;
        } else {
            result.x = event.clientX;
            result.y = event.clientY;
        }
        return result;
    }
    ;
    Owl.prototype.isNumeric = function(number) {
        return !isNaN(parseFloat(number));
    }
    ;
    Owl.prototype.difference = function(first, second) {
        return {
            x: first.x - second.x,
            y: first.y - second.y
        };
    }
    ;
    $.fn.owlCarousel = function(option) {
        var args = Array.prototype.slice.call(arguments, 1);
        return this.each(function() {
            var $this = $(this)
              , data = $this.data('owl.carousel');
            if (!data) {
                data = new Owl(this,typeof option == 'object' && option);
                $this.data('owl.carousel', data);
                $.each(['next', 'prev', 'to', 'destroy', 'refresh', 'replace', 'add', 'remove'], function(i, event) {
                    data.register({
                        type: Owl.Type.Event,
                        name: event
                    });
                    data.$element.on(event + '.owl.carousel.core', $.proxy(function(e) {
                        if (e.namespace && e.relatedTarget !== this) {
                            this.suppress([event]);
                            data[event].apply(this, [].slice.call(arguments, 1));
                            this.release([event]);
                        }
                    }, data));
                });
            }
            if (typeof option == 'string' && option.charAt(0) !== '_') {
                data[option].apply(data, args);
            }
        });
    }
    ;
    $.fn.owlCarousel.Constructor = Owl;
}
)(window.Zepto || window.jQuery, window, document);
;(function($, window, document, undefined) {
    var AutoRefresh = function(carousel) {
        this._core = carousel;
        this._interval = null;
        this._visible = null;
        this._handlers = {
            'initialized.owl.carousel': $.proxy(function(e) {
                if (e.namespace && this._core.settings.autoRefresh) {
                    this.watch();
                }
            }, this)
        };
        this._core.options = $.extend({}, AutoRefresh.Defaults, this._core.options);
        this._core.$element.on(this._handlers);
    };
    AutoRefresh.Defaults = {
        autoRefresh: true,
        autoRefreshInterval: 500
    };
    AutoRefresh.prototype.watch = function() {
        if (this._interval) {
            return;
        }
        this._visible = this._core.isVisible();
        this._interval = window.setInterval($.proxy(this.refresh, this), this._core.settings.autoRefreshInterval);
    }
    ;
    AutoRefresh.prototype.refresh = function() {
        if (this._core.isVisible() === this._visible) {
            return;
        }
        this._visible = !this._visible;
        this._core.$element.toggleClass('owl-hidden', !this._visible);
        this._visible && (this._core.invalidate('width') && this._core.refresh());
    }
    ;
    AutoRefresh.prototype.destroy = function() {
        var handler, property;
        window.clearInterval(this._interval);
        for (handler in this._handlers) {
            this._core.$element.off(handler, this._handlers[handler]);
        }
        for (property in Object.getOwnPropertyNames(this)) {
            typeof this[property] != 'function' && (this[property] = null);
        }
    }
    ;
    $.fn.owlCarousel.Constructor.Plugins.AutoRefresh = AutoRefresh;
}
)(window.Zepto || window.jQuery, window, document);
;(function($, window, document, undefined) {
    var Lazy = function(carousel) {
        this._core = carousel;
        this._loaded = [];
        this._handlers = {
            'initialized.owl.carousel change.owl.carousel resized.owl.carousel': $.proxy(function(e) {
                if (!e.namespace) {
                    return;
                }
                if (!this._core.settings || !this._core.settings.lazyLoad) {
                    return;
                }
                if ((e.property && e.property.name == 'position') || e.type == 'initialized') {
                    var settings = this._core.settings
                      , n = (settings.center && Math.ceil(settings.items / 2) || settings.items)
                      , i = ((settings.center && n * -1) || 0)
                      , position = (e.property && e.property.value !== undefined ? e.property.value : this._core.current()) + i
                      , clones = this._core.clones().length
                      , load = $.proxy(function(i, v) {
                        this.load(v)
                    }, this);
                    if (settings.lazyLoadEager > 0) {
                        n += settings.lazyLoadEager;
                        if (settings.loop) {
                            position -= settings.lazyLoadEager;
                            n++;
                        }
                    }
                    while (i++ < n) {
                        this.load(clones / 2 + this._core.relative(position));
                        clones && $.each(this._core.clones(this._core.relative(position)), load);
                        position++;
                    }
                }
            }, this)
        };
        this._core.options = $.extend({}, Lazy.Defaults, this._core.options);
        this._core.$element.on(this._handlers);
    };
    Lazy.Defaults = {
        lazyLoad: false,
        lazyLoadEager: 0
    };
    Lazy.prototype.load = function(position) {
        var $item = this._core.$stage.children().eq(position)
          , $elements = $item && $item.find('.owl-lazy');
        if (!$elements || $.inArray($item.get(0), this._loaded) > -1) {
            return;
        }
        $elements.each($.proxy(function(index, element) {
            var $element = $(element), image, url = (window.devicePixelRatio > 1 && $element.attr('data-src-retina')) || $element.attr('data-src') || $element.attr('data-srcset');
            this._core.trigger('load', {
                element: $element,
                url: url
            }, 'lazy');
            if ($element.is('img')) {
                $element.one('load.owl.lazy', $.proxy(function() {
                    $element.css('opacity', 1);
                    this._core.trigger('loaded', {
                        element: $element,
                        url: url
                    }, 'lazy');
                }, this)).attr('src', url);
            } else if ($element.is('source')) {
                $element.one('load.owl.lazy', $.proxy(function() {
                    this._core.trigger('loaded', {
                        element: $element,
                        url: url
                    }, 'lazy');
                }, this)).attr('srcset', url);
            } else {
                image = new Image();
                image.onload = $.proxy(function() {
                    $element.css({
                        'background-image': 'url("' + url + '")',
                        'opacity': '1'
                    });
                    this._core.trigger('loaded', {
                        element: $element,
                        url: url
                    }, 'lazy');
                }, this);
                image.src = url;
            }
        }, this));
        this._loaded.push($item.get(0));
    }
    ;
    Lazy.prototype.destroy = function() {
        var handler, property;
        for (handler in this.handlers) {
            this._core.$element.off(handler, this.handlers[handler]);
        }
        for (property in Object.getOwnPropertyNames(this)) {
            typeof this[property] != 'function' && (this[property] = null);
        }
    }
    ;
    $.fn.owlCarousel.Constructor.Plugins.Lazy = Lazy;
}
)(window.Zepto || window.jQuery, window, document);
;(function($, window, document, undefined) {
    var AutoHeight = function(carousel) {
        this._core = carousel;
        this._previousHeight = null;
        this._handlers = {
            'initialized.owl.carousel refreshed.owl.carousel': $.proxy(function(e) {
                if (e.namespace && this._core.settings.autoHeight) {
                    this.update();
                }
            }, this),
            'changed.owl.carousel': $.proxy(function(e) {
                if (e.namespace && this._core.settings.autoHeight && e.property.name === 'position') {
                    this.update();
                }
            }, this),
            'loaded.owl.lazy': $.proxy(function(e) {
                if (e.namespace && this._core.settings.autoHeight && e.element.closest('.' + this._core.settings.itemClass).index() === this._core.current()) {
                    this.update();
                }
            }, this)
        };
        this._core.options = $.extend({}, AutoHeight.Defaults, this._core.options);
        this._core.$element.on(this._handlers);
        this._intervalId = null;
        var refThis = this;
        $(window).on('load', function() {
            if (refThis._core.settings.autoHeight) {
                refThis.update();
            }
        });
        $(window).resize(function() {
            if (refThis._core.settings.autoHeight) {
                if (refThis._intervalId != null) {
                    clearTimeout(refThis._intervalId);
                }
                refThis._intervalId = setTimeout(function() {
                    refThis.update();
                }, 250);
            }
        });
    };
    AutoHeight.Defaults = {
        autoHeight: false,
        autoHeightClass: 'owl-height'
    };
    AutoHeight.prototype.update = function() {
        var start = this._core._current
          , end = start + this._core.settings.items
          , lazyLoadEnabled = this._core.settings.lazyLoad
          , visible = this._core.$stage.children().toArray().slice(start, end)
          , heights = []
          , maxheight = 0;
        $.each(visible, function(index, item) {
            heights.push($(item).height());
        });
        maxheight = Math.max.apply(null, heights);
        if (maxheight <= 1 && lazyLoadEnabled && this._previousHeight) {
            maxheight = this._previousHeight;
        }
        this._previousHeight = maxheight;
        this._core.$stage.parent().height(maxheight).addClass(this._core.settings.autoHeightClass);
    }
    ;
    AutoHeight.prototype.destroy = function() {
        var handler, property;
        for (handler in this._handlers) {
            this._core.$element.off(handler, this._handlers[handler]);
        }
        for (property in Object.getOwnPropertyNames(this)) {
            typeof this[property] !== 'function' && (this[property] = null);
        }
    }
    ;
    $.fn.owlCarousel.Constructor.Plugins.AutoHeight = AutoHeight;
}
)(window.Zepto || window.jQuery, window, document);
;(function($, window, document, undefined) {
    var Video = function(carousel) {
        this._core = carousel;
        this._videos = {};
        this._playing = null;
        this._handlers = {
            'initialized.owl.carousel': $.proxy(function(e) {
                if (e.namespace) {
                    this._core.register({
                        type: 'state',
                        name: 'playing',
                        tags: ['interacting']
                    });
                }
            }, this),
            'resize.owl.carousel': $.proxy(function(e) {
                if (e.namespace && this._core.settings.video && this.isInFullScreen()) {
                    e.preventDefault();
                }
            }, this),
            'refreshed.owl.carousel': $.proxy(function(e) {
                if (e.namespace && this._core.is('resizing')) {
                    this._core.$stage.find('.cloned .owl-video-frame').remove();
                }
            }, this),
            'changed.owl.carousel': $.proxy(function(e) {
                if (e.namespace && e.property.name === 'position' && this._playing) {
                    this.stop();
                }
            }, this),
            'prepared.owl.carousel': $.proxy(function(e) {
                if (!e.namespace) {
                    return;
                }
                var $element = $(e.content).find('.owl-video');
                if ($element.length) {
                    $element.css('display', 'none');
                    this.fetch($element, $(e.content));
                }
            }, this)
        };
        this._core.options = $.extend({}, Video.Defaults, this._core.options);
        this._core.$element.on(this._handlers);
        this._core.$element.on('click.owl.video', '.owl-video-play-icon', $.proxy(function(e) {
            this.play(e);
        }, this));
    };
    Video.Defaults = {
        video: false,
        videoHeight: false,
        videoWidth: false
    };
    Video.prototype.fetch = function(target, item) {
        var type = (function() {
            if (target.attr('data-vimeo-id')) {
                return 'vimeo';
            } else if (target.attr('data-vzaar-id')) {
                return 'vzaar'
            } else {
                return 'youtube';
            }
        }
        )()
          , id = target.attr('data-vimeo-id') || target.attr('data-youtube-id') || target.attr('data-vzaar-id')
          , width = target.attr('data-width') || this._core.settings.videoWidth
          , height = target.attr('data-height') || this._core.settings.videoHeight
          , url = target.attr('href');
        if (url) {
            id = url.match(/(http:|https:|)\/\/(player.|www.|app.)?(vimeo\.com|youtu(be\.com|\.be|be\.googleapis\.com|be\-nocookie\.com)|vzaar\.com)\/(video\/|videos\/|embed\/|channels\/.+\/|groups\/.+\/|watch\?v=|v\/)?([A-Za-z0-9._%-]*)(\&\S+)?/);
            if (id[3].indexOf('youtu') > -1) {
                type = 'youtube';
            } else if (id[3].indexOf('vimeo') > -1) {
                type = 'vimeo';
            } else if (id[3].indexOf('vzaar') > -1) {
                type = 'vzaar';
            } else {
                throw new Error('Video URL not supported.');
            }
            id = id[6];
        } else {
            throw new Error('Missing video URL.');
        }
        this._videos[url] = {
            type: type,
            id: id,
            width: width,
            height: height
        };
        item.attr('data-video', url);
        this.thumbnail(target, this._videos[url]);
    }
    ;
    Video.prototype.thumbnail = function(target, video) {
        var tnLink, icon, path, dimensions = video.width && video.height ? 'width:' + video.width + 'px;height:' + video.height + 'px;' : '', customTn = target.find('img'), srcType = 'src', lazyClass = '', settings = this._core.settings, create = function(path) {
            icon = '<div class="owl-video-play-icon"></div>';
            if (settings.lazyLoad) {
                tnLink = $('<div/>', {
                    "class": 'owl-video-tn ' + lazyClass,
                    "srcType": path
                });
            } else {
                tnLink = $('<div/>', {
                    "class": "owl-video-tn",
                    "style": 'opacity:1;background-image:url(' + path + ')'
                });
            }
            target.after(tnLink);
            target.after(icon);
        };
        target.wrap($('<div/>', {
            "class": "owl-video-wrapper",
            "style": dimensions
        }));
        if (this._core.settings.lazyLoad) {
            srcType = 'data-src';
            lazyClass = 'owl-lazy';
        }
        if (customTn.length) {
            create(customTn.attr(srcType));
            customTn.remove();
            return false;
        }
        if (video.type === 'youtube') {
            path = "//img.youtube.com/vi/" + video.id + "/hqdefault.jpg";
            create(path);
        } else if (video.type === 'vimeo') {
            $.ajax({
                type: 'GET',
                url: '//vimeo.com/api/v2/video/' + video.id + '.json',
                jsonp: 'callback',
                dataType: 'jsonp',
                success: function(data) {
                    path = data[0].thumbnail_large;
                    create(path);
                }
            });
        } else if (video.type === 'vzaar') {
            $.ajax({
                type: 'GET',
                url: '//vzaar.com/api/videos/' + video.id + '.json',
                jsonp: 'callback',
                dataType: 'jsonp',
                success: function(data) {
                    path = data.framegrab_url;
                    create(path);
                }
            });
        }
    }
    ;
    Video.prototype.stop = function() {
        this._core.trigger('stop', null, 'video');
        this._playing.find('.owl-video-frame').remove();
        this._playing.removeClass('owl-video-playing');
        this._playing = null;
        this._core.leave('playing');
        this._core.trigger('stopped', null, 'video');
    }
    ;
    Video.prototype.play = function(event) {
        var target = $(event.target), item = target.closest('.' + this._core.settings.itemClass), video = this._videos[item.attr('data-video')], width = video.width || '100%', height = video.height || this._core.$stage.height(), html, iframe;
        if (this._playing) {
            return;
        }
        this._core.enter('playing');
        this._core.trigger('play', null, 'video');
        item = this._core.items(this._core.relative(item.index()));
        this._core.reset(item.index());
        html = $('<iframe frameborder="0" allowfullscreen mozallowfullscreen webkitAllowFullScreen ></iframe>');
        html.attr('height', height);
        html.attr('width', width);
        if (video.type === 'youtube') {
            html.attr('src', '//www.youtube.com/embed/' + video.id + '?autoplay=1&rel=0&v=' + video.id);
        } else if (video.type === 'vimeo') {
            html.attr('src', '//player.vimeo.com/video/' + video.id + '?autoplay=1');
        } else if (video.type === 'vzaar') {
            html.attr('src', '//view.vzaar.com/' + video.id + '/player?autoplay=true');
        }
        iframe = $(html).wrap('<div class="owl-video-frame" />').insertAfter(item.find('.owl-video'));
        this._playing = item.addClass('owl-video-playing');
    }
    ;
    Video.prototype.isInFullScreen = function() {
        var element = document.fullscreenElement || document.mozFullScreenElement || document.webkitFullscreenElement;
        return element && $(element).parent().hasClass('owl-video-frame');
    }
    ;
    Video.prototype.destroy = function() {
        var handler, property;
        this._core.$element.off('click.owl.video');
        for (handler in this._handlers) {
            this._core.$element.off(handler, this._handlers[handler]);
        }
        for (property in Object.getOwnPropertyNames(this)) {
            typeof this[property] != 'function' && (this[property] = null);
        }
    }
    ;
    $.fn.owlCarousel.Constructor.Plugins.Video = Video;
}
)(window.Zepto || window.jQuery, window, document);
;(function($, window, document, undefined) {
    var Animate = function(scope) {
        this.core = scope;
        this.core.options = $.extend({}, Animate.Defaults, this.core.options);
        this.swapping = true;
        this.previous = undefined;
        this.next = undefined;
        this.handlers = {
            'change.owl.carousel': $.proxy(function(e) {
                if (e.namespace && e.property.name == 'position') {
                    this.previous = this.core.current();
                    this.next = e.property.value;
                }
            }, this),
            'drag.owl.carousel dragged.owl.carousel translated.owl.carousel': $.proxy(function(e) {
                if (e.namespace) {
                    this.swapping = e.type == 'translated';
                }
            }, this),
            'translate.owl.carousel': $.proxy(function(e) {
                if (e.namespace && this.swapping && (this.core.options.animateOut || this.core.options.animateIn)) {
                    this.swap();
                }
            }, this)
        };
        this.core.$element.on(this.handlers);
    };
    Animate.Defaults = {
        animateOut: false,
        animateIn: false
    };
    Animate.prototype.swap = function() {
        if (this.core.settings.items !== 1) {
            return;
        }
        if (!$.support.animation || !$.support.transition) {
            return;
        }
        this.core.speed(0);
        var left, clear = $.proxy(this.clear, this), previous = this.core.$stage.children().eq(this.previous), next = this.core.$stage.children().eq(this.next), incoming = this.core.settings.animateIn, outgoing = this.core.settings.animateOut;
        if (this.core.current() === this.previous) {
            return;
        }
        if (outgoing) {
            left = this.core.coordinates(this.previous) - this.core.coordinates(this.next);
            previous.one($.support.animation.end, clear).css({
                'left': left + 'px'
            }).addClass('animated owl-animated-out').addClass(outgoing);
        }
        if (incoming) {
            next.one($.support.animation.end, clear).addClass('animated owl-animated-in').addClass(incoming);
        }
    }
    ;
    Animate.prototype.clear = function(e) {
        $(e.target).css({
            'left': ''
        }).removeClass('animated owl-animated-out owl-animated-in').removeClass(this.core.settings.animateIn).removeClass(this.core.settings.animateOut);
        this.core.onTransitionEnd();
    }
    ;
    Animate.prototype.destroy = function() {
        var handler, property;
        for (handler in this.handlers) {
            this.core.$element.off(handler, this.handlers[handler]);
        }
        for (property in Object.getOwnPropertyNames(this)) {
            typeof this[property] != 'function' && (this[property] = null);
        }
    }
    ;
    $.fn.owlCarousel.Constructor.Plugins.Animate = Animate;
}
)(window.Zepto || window.jQuery, window, document);
;(function($, window, document, undefined) {
    var Autoplay = function(carousel) {
        this._core = carousel;
        this._call = null;
        this._time = 0;
        this._timeout = 0;
        this._paused = true;
        this._handlers = {
            'changed.owl.carousel': $.proxy(function(e) {
                if (e.namespace && e.property.name === 'settings') {
                    if (this._core.settings.autoplay) {
                        this.play();
                    } else {
                        this.stop();
                    }
                } else if (e.namespace && e.property.name === 'position' && this._paused) {
                    this._time = 0;
                }
            }, this),
            'initialized.owl.carousel': $.proxy(function(e) {
                if (e.namespace && this._core.settings.autoplay) {
                    this.play();
                }
            }, this),
            'play.owl.autoplay': $.proxy(function(e, t, s) {
                if (e.namespace) {
                    this.play(t, s);
                }
            }, this),
            'stop.owl.autoplay': $.proxy(function(e) {
                if (e.namespace) {
                    this.stop();
                }
            }, this),
            'mouseover.owl.autoplay': $.proxy(function() {
                if (this._core.settings.autoplayHoverPause && this._core.is('rotating')) {
                    this.pause();
                }
            }, this),
            'mouseleave.owl.autoplay': $.proxy(function() {
                if (this._core.settings.autoplayHoverPause && this._core.is('rotating')) {
                    this.play();
                }
            }, this),
            'touchstart.owl.core': $.proxy(function() {
                if (this._core.settings.autoplayHoverPause && this._core.is('rotating')) {
                    this.pause();
                }
            }, this),
            'touchend.owl.core': $.proxy(function() {
                if (this._core.settings.autoplayHoverPause) {
                    this.play();
                }
            }, this)
        };
        this._core.$element.on(this._handlers);
        this._core.options = $.extend({}, Autoplay.Defaults, this._core.options);
    };
    Autoplay.Defaults = {
        autoplay: false,
        autoplayTimeout: 5000,
        autoplayHoverPause: false,
        autoplaySpeed: false
    };
    Autoplay.prototype._next = function(speed) {
        this._call = window.setTimeout($.proxy(this._next, this, speed), this._timeout * (Math.round(this.read() / this._timeout) + 1) - this.read());
        if (this._core.is('interacting') || document.hidden) {
            return;
        }
        this._core.next(speed || this._core.settings.autoplaySpeed);
    }
    Autoplay.prototype.read = function() {
        return new Date().getTime() - this._time;
    }
    ;
    Autoplay.prototype.play = function(timeout, speed) {
        var elapsed;
        if (!this._core.is('rotating')) {
            this._core.enter('rotating');
        }
        timeout = timeout || this._core.settings.autoplayTimeout;
        elapsed = Math.min(this._time % (this._timeout || timeout), timeout);
        if (this._paused) {
            this._time = this.read();
            this._paused = false;
        } else {
            window.clearTimeout(this._call);
        }
        this._time += this.read() % timeout - elapsed;
        this._timeout = timeout;
        this._call = window.setTimeout($.proxy(this._next, this, speed), timeout - elapsed);
    }
    ;
    Autoplay.prototype.stop = function() {
        if (this._core.is('rotating')) {
            this._time = 0;
            this._paused = true;
            window.clearTimeout(this._call);
            this._core.leave('rotating');
        }
    }
    ;
    Autoplay.prototype.pause = function() {
        if (this._core.is('rotating') && !this._paused) {
            this._time = this.read();
            this._paused = true;
            window.clearTimeout(this._call);
        }
    }
    ;
    Autoplay.prototype.destroy = function() {
        var handler, property;
        this.stop();
        for (handler in this._handlers) {
            this._core.$element.off(handler, this._handlers[handler]);
        }
        for (property in Object.getOwnPropertyNames(this)) {
            typeof this[property] != 'function' && (this[property] = null);
        }
    }
    ;
    $.fn.owlCarousel.Constructor.Plugins.autoplay = Autoplay;
}
)(window.Zepto || window.jQuery, window, document);
;(function($, window, document, undefined) {
    'use strict';
    var Navigation = function(carousel) {
        this._core = carousel;
        this._initialized = false;
        this._pages = [];
        this._controls = {};
        this._templates = [];
        this.$element = this._core.$element;
        this._overrides = {
            next: this._core.next,
            prev: this._core.prev,
            to: this._core.to
        };
        this._handlers = {
            'prepared.owl.carousel': $.proxy(function(e) {
                if (e.namespace && this._core.settings.dotsData) {
                    this._templates.push('<div class="' + this._core.settings.dotClass + '">' + $(e.content).find('[data-dot]').addBack('[data-dot]').attr('data-dot') + '</div>');
                }
            }, this),
            'added.owl.carousel': $.proxy(function(e) {
                if (e.namespace && this._core.settings.dotsData) {
                    this._templates.splice(e.position, 0, this._templates.pop());
                }
            }, this),
            'remove.owl.carousel': $.proxy(function(e) {
                if (e.namespace && this._core.settings.dotsData) {
                    this._templates.splice(e.position, 1);
                }
            }, this),
            'changed.owl.carousel': $.proxy(function(e) {
                if (e.namespace && e.property.name == 'position') {
                    this.draw();
                }
            }, this),
            'initialized.owl.carousel': $.proxy(function(e) {
                if (e.namespace && !this._initialized) {
                    this._core.trigger('initialize', null, 'navigation');
                    this.initialize();
                    this.update();
                    this.draw();
                    this._initialized = true;
                    this._core.trigger('initialized', null, 'navigation');
                }
            }, this),
            'refreshed.owl.carousel': $.proxy(function(e) {
                if (e.namespace && this._initialized) {
                    this._core.trigger('refresh', null, 'navigation');
                    this.update();
                    this.draw();
                    this._core.trigger('refreshed', null, 'navigation');
                }
            }, this)
        };
        this._core.options = $.extend({}, Navigation.Defaults, this._core.options);
        this.$element.on(this._handlers);
    };
    Navigation.Defaults = {
        nav: false,
        navText: ['<span aria-label="' + 'Previous' + '">&#x2039;</span>', '<span aria-label="' + 'Next' + '">&#x203a;</span>'],
        navSpeed: false,
        navElement: 'button type="button" role="presentation"',
        navContainer: false,
        navContainerClass: 'owl-nav',
        navClass: ['owl-prev', 'owl-next'],
        slideBy: 1,
        dotClass: 'owl-dot',
        dotsClass: 'owl-dots',
        dots: true,
        dotsEach: false,
        dotsData: false,
        dotsSpeed: false,
        dotsContainer: false
    };
    Navigation.prototype.initialize = function() {
        var override, settings = this._core.settings;
        this._controls.$relative = (settings.navContainer ? $(settings.navContainer) : $('<div>').addClass(settings.navContainerClass).appendTo(this.$element)).addClass('disabled');
        this._controls.$previous = $('<' + settings.navElement + '>').addClass(settings.navClass[0]).html(settings.navText[0]).prependTo(this._controls.$relative).on('click', $.proxy(function(e) {
            this.prev(settings.navSpeed);
        }, this));
        this._controls.$next = $('<' + settings.navElement + '>').addClass(settings.navClass[1]).html(settings.navText[1]).appendTo(this._controls.$relative).on('click', $.proxy(function(e) {
            this.next(settings.navSpeed);
        }, this));
        if (!settings.dotsData) {
            this._templates = [$('<button role="button">').addClass(settings.dotClass).append($('<span>')).prop('outerHTML')];
        }
        this._controls.$absolute = (settings.dotsContainer ? $(settings.dotsContainer) : $('<div>').addClass(settings.dotsClass).appendTo(this.$element)).addClass('disabled');
        this._controls.$absolute.on('click', 'button', $.proxy(function(e) {
            var index = $(e.target).parent().is(this._controls.$absolute) ? $(e.target).index() : $(e.target).parent().index();
            e.preventDefault();
            this.to(index, settings.dotsSpeed);
        }, this));
        for (override in this._overrides) {
            this._core[override] = $.proxy(this[override], this);
        }
    }
    ;
    Navigation.prototype.destroy = function() {
        var handler, control, property, override, settings;
        settings = this._core.settings;
        for (handler in this._handlers) {
            this.$element.off(handler, this._handlers[handler]);
        }
        for (control in this._controls) {
            if (control === '$relative' && settings.navContainer) {
                this._controls[control].html('');
            } else {
                this._controls[control].remove();
            }
        }
        for (override in this.overides) {
            this._core[override] = this._overrides[override];
        }
        for (property in Object.getOwnPropertyNames(this)) {
            typeof this[property] != 'function' && (this[property] = null);
        }
    }
    ;
    Navigation.prototype.update = function() {
        var i, j, k, lower = this._core.clones().length / 2, upper = lower + this._core.items().length, maximum = this._core.maximum(true), settings = this._core.settings, size = settings.center || settings.autoWidth || settings.dotsData ? 1 : settings.dotsEach || settings.items;
        if (settings.slideBy !== 'page') {
            settings.slideBy = Math.min(settings.slideBy, settings.items);
        }
        if (settings.dots || settings.slideBy == 'page') {
            this._pages = [];
            for (i = lower,
            j = 0,
            k = 0; i < upper; i++) {
                if (j >= size || j === 0) {
                    this._pages.push({
                        start: Math.min(maximum, i - lower),
                        end: i - lower + size - 1
                    });
                    if (Math.min(maximum, i - lower) === maximum) {
                        break;
                    }
                    j = 0,
                    ++k;
                }
                j += this._core.mergers(this._core.relative(i));
            }
        }
    }
    ;
    Navigation.prototype.draw = function() {
        var difference, settings = this._core.settings, disabled = this._core.items().length <= settings.items, index = this._core.relative(this._core.current()), loop = settings.loop || settings.rewind;
        this._controls.$relative.toggleClass('disabled', !settings.nav || disabled);
        if (settings.nav) {
            this._controls.$previous.toggleClass('disabled', !loop && index <= this._core.minimum(true));
            this._controls.$next.toggleClass('disabled', !loop && index >= this._core.maximum(true));
        }
        this._controls.$absolute.toggleClass('disabled', !settings.dots || disabled);
        if (settings.dots) {
            difference = this._pages.length - this._controls.$absolute.children().length;
            if (settings.dotsData && difference !== 0) {
                this._controls.$absolute.html(this._templates.join(''));
            } else if (difference > 0) {
                this._controls.$absolute.append(new Array(difference + 1).join(this._templates[0]));
            } else if (difference < 0) {
                this._controls.$absolute.children().slice(difference).remove();
            }
            this._controls.$absolute.find('.active').removeClass('active');
            this._controls.$absolute.children().eq($.inArray(this.current(), this._pages)).addClass('active');
        }
    }
    ;
    Navigation.prototype.onTrigger = function(event) {
        var settings = this._core.settings;
        event.page = {
            index: $.inArray(this.current(), this._pages),
            count: this._pages.length,
            size: settings && (settings.center || settings.autoWidth || settings.dotsData ? 1 : settings.dotsEach || settings.items)
        };
    }
    ;
    Navigation.prototype.current = function() {
        var current = this._core.relative(this._core.current());
        return $.grep(this._pages, $.proxy(function(page, index) {
            return page.start <= current && page.end >= current;
        }, this)).pop();
    }
    ;
    Navigation.prototype.getPosition = function(successor) {
        var position, length, settings = this._core.settings;
        if (settings.slideBy == 'page') {
            position = $.inArray(this.current(), this._pages);
            length = this._pages.length;
            successor ? ++position : --position;
            position = this._pages[((position % length) + length) % length].start;
        } else {
            position = this._core.relative(this._core.current());
            length = this._core.items().length;
            successor ? position += settings.slideBy : position -= settings.slideBy;
        }
        return position;
    }
    ;
    Navigation.prototype.next = function(speed) {
        $.proxy(this._overrides.to, this._core)(this.getPosition(true), speed);
    }
    ;
    Navigation.prototype.prev = function(speed) {
        $.proxy(this._overrides.to, this._core)(this.getPosition(false), speed);
    }
    ;
    Navigation.prototype.to = function(position, speed, standard) {
        var length;
        if (!standard && this._pages.length) {
            length = this._pages.length;
            $.proxy(this._overrides.to, this._core)(this._pages[((position % length) + length) % length].start, speed);
        } else {
            $.proxy(this._overrides.to, this._core)(position, speed);
        }
    }
    ;
    $.fn.owlCarousel.Constructor.Plugins.Navigation = Navigation;
}
)(window.Zepto || window.jQuery, window, document);
;(function($, window, document, undefined) {
    'use strict';
    var Hash = function(carousel) {
        this._core = carousel;
        this._hashes = {};
        this.$element = this._core.$element;
        this._handlers = {
            'initialized.owl.carousel': $.proxy(function(e) {
                if (e.namespace && this._core.settings.startPosition === 'URLHash') {
                    $(window).trigger('hashchange.owl.navigation');
                }
            }, this),
            'prepared.owl.carousel': $.proxy(function(e) {
                if (e.namespace) {
                    var hash = $(e.content).find('[data-hash]').addBack('[data-hash]').attr('data-hash');
                    if (!hash) {
                        return;
                    }
                    this._hashes[hash] = e.content;
                }
            }, this),
            'changed.owl.carousel': $.proxy(function(e) {
                if (e.namespace && e.property.name === 'position') {
                    var current = this._core.items(this._core.relative(this._core.current()))
                      , hash = $.map(this._hashes, function(item, hash) {
                        return item === current ? hash : null;
                    }).join();
                    if (!hash || window.location.hash.slice(1) === hash) {
                        return;
                    }
                    window.location.hash = hash;
                }
            }, this)
        };
        this._core.options = $.extend({}, Hash.Defaults, this._core.options);
        this.$element.on(this._handlers);
        $(window).on('hashchange.owl.navigation', $.proxy(function(e) {
            var hash = window.location.hash.substring(1)
              , items = this._core.$stage.children()
              , position = this._hashes[hash] && items.index(this._hashes[hash]);
            if (position === undefined || position === this._core.current()) {
                return;
            }
            this._core.to(this._core.relative(position), false, true);
        }, this));
    };
    Hash.Defaults = {
        URLhashListener: false
    };
    Hash.prototype.destroy = function() {
        var handler, property;
        $(window).off('hashchange.owl.navigation');
        for (handler in this._handlers) {
            this._core.$element.off(handler, this._handlers[handler]);
        }
        for (property in Object.getOwnPropertyNames(this)) {
            typeof this[property] != 'function' && (this[property] = null);
        }
    }
    ;
    $.fn.owlCarousel.Constructor.Plugins.Hash = Hash;
}
)(window.Zepto || window.jQuery, window, document);
;(function($, window, document, undefined) {
    var style = $('<support>').get(0).style
      , prefixes = 'Webkit Moz O ms'.split(' ')
      , events = {
        transition: {
            end: {
                WebkitTransition: 'webkitTransitionEnd',
                MozTransition: 'transitionend',
                OTransition: 'oTransitionEnd',
                transition: 'transitionend'
            }
        },
        animation: {
            end: {
                WebkitAnimation: 'webkitAnimationEnd',
                MozAnimation: 'animationend',
                OAnimation: 'oAnimationEnd',
                animation: 'animationend'
            }
        }
    }
      , tests = {
        csstransforms: function() {
            return !!test('transform');
        },
        csstransforms3d: function() {
            return !!test('perspective');
        },
        csstransitions: function() {
            return !!test('transition');
        },
        cssanimations: function() {
            return !!test('animation');
        }
    };
    function test(property, prefixed) {
        var result = false
          , upper = property.charAt(0).toUpperCase() + property.slice(1);
        $.each((property + ' ' + prefixes.join(upper + ' ') + upper).split(' '), function(i, property) {
            if (style[property] !== undefined) {
                result = prefixed ? property : true;
                return false;
            }
        });
        return result;
    }
    function prefixed(property) {
        return test(property, true);
    }
    if (tests.csstransitions()) {
        $.support.transition = new String(prefixed('transition'))
        $.support.transition.end = events.transition.end[$.support.transition];
    }
    if (tests.cssanimations()) {
        $.support.animation = new String(prefixed('animation'))
        $.support.animation.end = events.animation.end[$.support.animation];
    }
    if (tests.csstransforms()) {
        $.support.transform = new String(prefixed('transform'));
        $.support.transform3d = tests.csstransforms3d();
    }
}
)(window.Zepto || window.jQuery, window, document);
(function($) {
    var blocksOptions = {
        numOfCol: 5,
        offsetX: 5,
        offsetY: 5,
        blockElement: 'div',
        reverse: false,
        onlyAdded: false
    };
    var $container, colwidth;
    var blockarr = []
      , block_count = 0;
    var createEmptyBlockarr = function() {
        var offsetY = blocksOptions.offsetY;
        blockarr = [];
        for (var i = 0, len = blocksOptions.numOfCol; i < len; i += 1) {
            blockarr.push(offsetY);
        }
        block_count = 0;
    };
    var getBlockPosition = function() {
        var minIndex = 0;
        var minHeight = blockarr[0];
        for (var i = 1, len = blockarr.length; i < len; i += 1) {
            if (blockarr[i] < minHeight) {
                minIndex = i;
                minHeight = blockarr[i];
            }
        }
        return [minIndex, minHeight];
    };
    var setPosition = function(obj) {
        var pos = getBlockPosition();
        var blockWidth = colwidth - (obj.outerWidth() - obj.width());
        var css_set = {
            'width': blockWidth - blocksOptions.offsetX * 2,
            'left': pos[0] * colwidth,
            'position': 'absolute'
        };
        if (blocksOptions.reverse) {
            css_set.bottom = pos[1];
        } else {
            css_set.top = pos[1];
        }
        obj.css(css_set);
        var blockHeight = obj.outerHeight();
        blockarr[pos[0]] = pos[1] + blockHeight + blocksOptions.offsetY * 2;
    };
    $.fn.BlocksIt = function(options) {
        var $children;
        if (options && typeof options === 'object') {
            $.extend(blocksOptions, options);
        }
        if (blocksOptions.onlyAdded && (block_count === 0 || blockarr.length === 0)) {
            blocksOptions.onlyAdded = false;
        }
        $container = $(this);
        colwidth = $container.width() / blocksOptions.numOfCol;
        if (!blocksOptions.onlyAdded) {
            createEmptyBlockarr();
        }
        $children = $container.children(blocksOptions.blockElement);
        if (blocksOptions.reverse) {
            $children = [].reverse.call($children);
        }
        if (blocksOptions.onlyAdded) {
            $children = $children.slice(block_count);
        }
        $children.each(function() {
            setPosition($(this));
            block_count += 1;
        });
        $container.height(Math.max.apply(null, blockarr) + blocksOptions.offsetY);
        return this;
    }
}
)(jQuery);
(function(r, d) {
    "function" === typeof define && define.amd ? define(["jquery"], function(z) {
        return d(r, z)
    }) : "object" === typeof exports ? d(r, require("jquery")) : d(r, r.jQuery)
}
)("undefined" !== typeof window ? window : this, function(r, d) {
    function z(a, b) {
        for (var c = a.length; --c; )
            if (Math.round(+a[c]) !== Math.round(+b[c]))
                return !1;
        return !0
    }
    function w(a) {
        var b = {
            range: !0,
            animate: !0
        };
        "boolean" === typeof a ? b.animate = a : d.extend(b, a);
        return b
    }
    function q(a, b, c, g, e, h, f, k, l) {
        "array" === d.type(a) ? this.elements = [+a[0], +a[2], +a[4], +a[1], +a[3], +a[5], 0, 0, 1] : this.elements = [a, b, c, g, e, h, f || 0, k || 0, l || 1]
    }
    function u(a, b, c) {
        this.elements = [a, b, c]
    }
    function n(a, b) {
        if (!(this instanceof n))
            return new n(a,b);
        1 !== a.nodeType && d.error("Panzoom called on non-Element node");
        d.contains(y, a) || d.error("Panzoom element must be attached to the document");
        var c = d.data(a, "__pz__");
        if (c)
            return c;
        this.options = b = d.extend({}, n.defaults, b);
        this.elem = a;
        c = this.$elem = d(a);
        this.$set = b.$set && b.$set.length ? b.$set : c;
        this.$doc = d(a.ownerDocument || y);
        this.$parent = c.parent();
        this.parent = this.$parent[0];
        this.isSVG = A.test(a.namespaceURI) && "svg" !== a.nodeName.toLowerCase();
        this.panning = !1;
        this._buildTransform();
        this._transform = d.cssProps.transform.replace(B, "-$1").toLowerCase();
        this._buildTransition();
        this.resetDimensions();
        var g = d()
          , e = this;
        d.each(["$zoomIn", "$zoomOut", "$zoomRange", "$reset"], function(a, c) {
            e[c] = b[c] || g
        });
        this.enable();
        this.scale = this.getMatrix()[0];
        this._checkPanWhenZoomed();
        d.data(a, "__pz__", this)
    }
    var y = r.document
      , x = Array.prototype.slice
      , C = /trident\/7./i
      , D = function() {
        if (C.test(navigator.userAgent))
            return !1;
        var a = y.createElement("input");
        a.setAttribute("oninput", "return");
        return "function" === typeof a.oninput
    }()
      , B = /([A-Z])/g
      , A = /^http:[\w\.\/]+svg$/
      , v = /^matrix\((\-?\d[\d\.e-]*)\,?\s*(\-?\d[\d\.e-]*)\,?\s*(\-?\d[\d\.e-]*)\,?\s*(\-?\d[\d\.e-]*)\,?\s*(\-?\d[\d\.e-]*)\,?\s*(\-?\d[\d\.e-]*)\)$/;
    q.prototype = {
        x: function(a) {
            var b = this.elements
              , c = a.elements;
            return a instanceof u && 3 === c.length ? new u(b[0] * c[0] + b[1] * c[1] + b[2] * c[2],b[3] * c[0] + b[4] * c[1] + b[5] * c[2],b[6] * c[0] + b[7] * c[1] + b[8] * c[2]) : c.length === b.length ? new q(b[0] * c[0] + b[1] * c[3] + b[2] * c[6],b[0] * c[1] + b[1] * c[4] + b[2] * c[7],b[0] * c[2] + b[1] * c[5] + b[2] * c[8],b[3] * c[0] + b[4] * c[3] + b[5] * c[6],b[3] * c[1] + b[4] * c[4] + b[5] * c[7],b[3] * c[2] + b[4] * c[5] + b[5] * c[8],b[6] * c[0] + b[7] * c[3] + b[8] * c[6],b[6] * c[1] + b[7] * c[4] + b[8] * c[7],b[6] * c[2] + b[7] * c[5] + b[8] * c[8]) : !1
        },
        inverse: function() {
            var a = 1 / this.determinant()
              , b = this.elements;
            return new q(a * (b[8] * b[4] - b[7] * b[5]),a * -(b[8] * b[1] - b[7] * b[2]),a * (b[5] * b[1] - b[4] * b[2]),a * -(b[8] * b[3] - b[6] * b[5]),a * (b[8] * b[0] - b[6] * b[2]),a * -(b[5] * b[0] - b[3] * b[2]),a * (b[7] * b[3] - b[6] * b[4]),a * -(b[7] * b[0] - b[6] * b[1]),a * (b[4] * b[0] - b[3] * b[1]))
        },
        determinant: function() {
            var a = this.elements;
            return a[0] * (a[8] * a[4] - a[7] * a[5]) - a[3] * (a[8] * a[1] - a[7] * a[2]) + a[6] * (a[5] * a[1] - a[4] * a[2])
        }
    };
    u.prototype.e = q.prototype.e = function(a) {
        return this.elements[a]
    }
    ;
    n.rmatrix = v;
    n.defaults = {
        eventNamespace: ".panzoom",
        transition: !0,
        cursor: "move",
        disablePan: !1,
        disableZoom: !1,
        disableXAxis: !1,
        disableYAxis: !1,
        which: 1,
        increment: .3,
        linearZoom: !1,
        panOnlyWhenZoomed: !1,
        minScale: .3,
        maxScale: 6,
        rangeStep: .05,
        duration: 200,
        easing: "ease-in-out",
        contain: !1
    };
    n.prototype = {
        constructor: n,
        instance: function() {
            return this
        },
        enable: function() {
            this._initStyle();
            this._bind();
            this.disabled = !1
        },
        disable: function() {
            this.disabled = !0;
            this._resetStyle();
            this._unbind()
        },
        isDisabled: function() {
            return this.disabled
        },
        destroy: function() {
            this.disable();
            d.removeData(this.elem, "__pz__")
        },
        resetDimensions: function() {
            this.container = this.parent.getBoundingClientRect();
            var a = this.elem
              , b = a.getBoundingClientRect()
              , c = Math.abs(this.scale);
            this.dimensions = {
                width: b.width,
                height: b.height,
                left: d.css(a, "left", !0) || 0,
                top: d.css(a, "top", !0) || 0,
                border: {
                    top: d.css(a, "borderTopWidth", !0) * c || 0,
                    bottom: d.css(a, "borderBottomWidth", !0) * c || 0,
                    left: d.css(a, "borderLeftWidth", !0) * c || 0,
                    right: d.css(a, "borderRightWidth", !0) * c || 0
                },
                margin: {
                    top: d.css(a, "marginTop", !0) * c || 0,
                    left: d.css(a, "marginLeft", !0) * c || 0
                }
            }
        },
        reset: function(a) {
            a = w(a);
            var b = this.setMatrix(this._origTransform, a);
            a.silent || this._trigger("reset", b)
        },
        resetZoom: function(a) {
            a = w(a);
            var b = this.getMatrix(this._origTransform);
            a.dValue = b[3];
            this.zoom(b[0], a)
        },
        resetPan: function(a) {
            var b = this.getMatrix(this._origTransform);
            this.pan(b[4], b[5], w(a))
        },
        setTransform: function(a) {
            for (var b = this.$set, c = b.length; c--; )
                d.style(b[c], "transform", a),
                this.isSVG && b[c].setAttribute("transform", a)
        },
        getTransform: function(a) {
            var b = this.$set[0];
            a ? this.setTransform(a) : (a = d.style(b, "transform"),
            !this.isSVG || a && "none" !== a || (a = d.attr(b, "transform") || "none"));
            "none" === a || v.test(a) || this.setTransform(a = d.css(b, "transform"));
            return a || "none"
        },
        getMatrix: function(a) {
            (a = v.exec(a || this.getTransform())) && a.shift();
            return a || [1, 0, 0, 1, 0, 0]
        },
        setMatrix: function(a, b) {
            if (!this.disabled) {
                b || (b = {});
                "string" === typeof a && (a = this.getMatrix(a));
                var c = +a[0]
                  , g = "undefined" !== typeof b.contain ? b.contain : this.options.contain;
                if (g) {
                    var e = b.dims;
                    e || (this.resetDimensions(),
                    e = this.dimensions);
                    var h, f, k;
                    h = this.container;
                    f = e.width;
                    var l = e.height
                      , m = h.width
                      , p = h.height
                      , n = m / f
                      , q = p / l;
                    "center" !== this.$parent.css("textAlign") || "inline" !== d.css(this.elem, "display") ? (k = (f - this.elem.offsetWidth) / 2,
                    h = k - e.border.left,
                    f = f - m - k + e.border.right) : h = f = (f - m) / 2;
                    m = (l - p) / 2 + e.border.top;
                    l = (l - p) / 2 - e.border.top - e.border.bottom;
                    a[4] = "invert" === g || "automatic" === g && 1.01 > n ? Math.max(Math.min(a[4], h - e.border.left), -f) : Math.min(Math.max(a[4], h), -f);
                    a[5] = "invert" === g || "automatic" === g && 1.01 > q ? Math.max(Math.min(a[5], m - e.border.top), -l) : Math.min(Math.max(a[5], m), -l)
                }
                "skip" !== b.animate && this.transition(!b.animate);
                b.range && this.$zoomRange.val(c);
                if (this.options.disableXAxis || this.options.disableYAxis)
                    g = this.getMatrix(),
                    this.options.disableXAxis && (a[4] = g[4]),
                    this.options.disableYAxis && (a[5] = g[5]);
                this.setTransform("matrix(" + a.join(",") + ")");
                this.scale = c;
                this._checkPanWhenZoomed(c);
                b.silent || this._trigger("change", a);
                return a
            }
        },
        isPanning: function() {
            return this.panning
        },
        transition: function(a) {
            if (this._transition) {
                a = a || !this.options.transition ? "none" : this._transition;
                for (var b = this.$set, c = b.length; c--; )
                    d.style(b[c], "transition") !== a && d.style(b[c], "transition", a)
            }
        },
        pan: function(a, b, c) {
            if (!this.options.disablePan) {
                c || (c = {});
                var d = c.matrix;
                d || (d = this.getMatrix());
                c.relative && (a += +d[4],
                b += +d[5]);
                d[4] = a;
                d[5] = b;
                this.setMatrix(d, c);
                c.silent || this._trigger("pan", d[4], d[5])
            }
        },
        zoom: function(a, b) {
            "object" === typeof a ? (b = a,
            a = null) : b || (b = {});
            var c = d.extend({}, this.options, b);
            if (!c.disableZoom) {
                var g = !1
                  , e = c.matrix || this.getMatrix()
                  , h = +e[0];
                "number" !== typeof a && (a = c.linearZoom ? h + c.increment * (a ? -1 : 1) : a ? h / (1 + c.increment) : h * (1 + c.increment),
                g = !0);
                a = Math.max(Math.min(a, c.maxScale), c.minScale);
                var f = c.focal;
                if (f && !c.disablePan) {
                    this.resetDimensions();
                    var k = c.dims = this.dimensions
                      , l = f.clientX
                      , f = f.clientY;
                    this.isSVG || (l -= k.width / h / 2,
                    f -= k.height / h / 2);
                    var m = new u(l,f,1)
                      , h = new q(e)
                      , k = this.parentOffset || this.$parent.offset()
                      , k = new q(1,0,k.left - this.$doc.scrollLeft(),0,1,k.top - this.$doc.scrollTop())
                      , m = h.inverse().x(k.inverse().x(m))
                      , p = a / e[0]
                      , h = h.x(new q([p, 0, 0, p, 0, 0]))
                      , m = k.x(h.x(m));
                    e[4] = +e[4] + (l - m.e(0));
                    e[5] = +e[5] + (f - m.e(1))
                }
                e[0] = a;
                e[3] = "number" === typeof c.dValue ? c.dValue : a;
                this.setMatrix(e, {
                    animate: "undefined" !== typeof c.animate ? c.animate : g,
                    range: !c.noSetRange
                });
                c.silent || this._trigger("zoom", e[0], c)
            }
        },
        option: function(a, b) {
            var c;
            if (!a)
                return d.extend({}, this.options);
            if ("string" === typeof a) {
                if (1 === arguments.length)
                    return void 0 !== this.options[a] ? this.options[a] : null;
                c = {};
                c[a] = b
            } else
                c = a;
            this._setOptions(c)
        },
        _setOptions: function(a) {
            d.each(a, d.proxy(function(a, c) {
                switch (a) {
                case "disablePan":
                    this._resetStyle();
                case "$zoomIn":
                case "$zoomOut":
                case "$zoomRange":
                case "$reset":
                case "disableZoom":
                case "onStart":
                case "onChange":
                case "onZoom":
                case "onPan":
                case "onEnd":
                case "onReset":
                case "eventNamespace":
                    this._unbind()
                }
                this.options[a] = c;
                switch (a) {
                case "disablePan":
                    this._initStyle();
                case "$zoomIn":
                case "$zoomOut":
                case "$zoomRange":
                case "$reset":
                    this[a] = c;
                case "disableZoom":
                case "onStart":
                case "onChange":
                case "onZoom":
                case "onPan":
                case "onEnd":
                case "onReset":
                case "eventNamespace":
                    this._bind();
                    break;
                case "cursor":
                    d.style(this.elem, "cursor", c);
                    break;
                case "minScale":
                    this.$zoomRange.attr("min", c);
                    break;
                case "maxScale":
                    this.$zoomRange.attr("max", c);
                    break;
                case "rangeStep":
                    this.$zoomRange.attr("step", c);
                    break;
                case "startTransform":
                    this._buildTransform();
                    break;
                case "duration":
                case "easing":
                    this._buildTransition();
                case "transition":
                    this.transition();
                    break;
                case "panOnlyWhenZoomed":
                    this._checkPanWhenZoomed();
                    break;
                case "$set":
                    c instanceof d && c.length && (this.$set = c,
                    this._initStyle(),
                    this._buildTransform())
                }
            }, this))
        },
        _checkPanWhenZoomed: function(a) {
            var b = this.options;
            b.panOnlyWhenZoomed && (a || (a = this.getMatrix()[0]),
            a = a <= b.minScale,
            b.disablePan !== a && this.option("disablePan", a))
        },
        _initStyle: function() {
            var a = {
                "transform-origin": this.isSVG ? "0 0" : "50% 50%"
            };
            this.options.disablePan || (a.cursor = this.options.cursor);
            this.$set.css(a);
            var b = this.$parent;
            b.length && !d.nodeName(this.parent, "body") && (a = {
                overflow: "hidden"
            },
            "static" === b.css("position") && (a.position = "relative"),
            b.css(a))
        },
        _resetStyle: function() {
            this.$elem.css({
                cursor: "",
                transition: ""
            });
            this.$parent.css({
                overflow: "",
                position: ""
            })
        },
        _bind: function() {
            var a = this
              , b = this.options
              , c = b.eventNamespace
              , g = "mousedown" + c + " pointerdown" + c + " MSPointerDown" + c
              , e = "touchstart" + c + " " + g
              , h = "touchend" + c + " click" + c + " pointerup" + c + " MSPointerUp" + c
              , f = {}
              , k = this.$reset
              , l = this.$zoomRange;
            d.each("Start Change Zoom Pan End Reset".split(" "), function() {
                var a = b["on" + this];
                d.isFunction(a) && (f["panzoom" + this.toLowerCase() + c] = a)
            });
            b.disablePan && b.disableZoom || (f[e] = function(c) {
                var d;
                ("touchstart" === c.type ? !(d = c.touches || c.originalEvent.touches) || (1 !== d.length || b.disablePan) && 2 !== d.length : b.disablePan || (c.which || c.originalEvent.which) !== b.which) || (c.preventDefault(),
                c.stopPropagation(),
                a._startMove(c, d))
            }
            ,
            3 === b.which && (f.contextmenu = !1));
            this.$elem.on(f);
            if (k.length)
                k.on(h, function(b) {
                    b.preventDefault();
                    a.reset()
                });
            l.length && l.attr({
                step: b.rangeStep === n.defaults.rangeStep && l.attr("step") || b.rangeStep,
                min: b.minScale,
                max: b.maxScale
            }).prop({
                value: this.getMatrix()[0]
            });
            b.disableZoom || (e = this.$zoomIn,
            k = this.$zoomOut,
            e.length && k.length && (e.on(h, function(b) {
                b.preventDefault();
                a.zoom()
            }),
            k.on(h, function(b) {
                b.preventDefault();
                a.zoom(!0)
            })),
            l.length && (f = {},
            f[g] = function() {
                a.transition(!0)
            }
            ,
            f[(D ? "input" : "change") + c] = function() {
                a.zoom(+this.value, {
                    noSetRange: !0
                })
            }
            ,
            l.on(f)))
        },
        _unbind: function() {
            this.$elem.add(this.$zoomIn).add(this.$zoomOut).add(this.$reset).off(this.options.eventNamespace)
        },
        _buildTransform: function() {
            return this._origTransform = this.getTransform(this.options.startTransform)
        },
        _buildTransition: function() {
            if (this._transform) {
                var a = this.options;
                this._transition = this._transform + " " + a.duration + "ms " + a.easing
            }
        },
        _getDistance: function(a) {
            var b = a[0];
            a = a[1];
            return Math.sqrt(Math.pow(Math.abs(a.clientX - b.clientX), 2) + Math.pow(Math.abs(a.clientY - b.clientY), 2))
        },
        _getMiddle: function(a) {
            var b = a[0];
            a = a[1];
            return {
                clientX: (a.clientX - b.clientX) / 2 + b.clientX,
                clientY: (a.clientY - b.clientY) / 2 + b.clientY
            }
        },
        _trigger: function(a) {
            "string" === typeof a && (a = "panzoom" + a);
            this.$elem.triggerHandler(a, [this].concat(x.call(arguments, 1)))
        },
        _startMove: function(a, b) {
            if (!this.panning) {
                var c, g, e, h, f, k, l, m, p = this, n = this.options, q = n.eventNamespace, t = this.getMatrix(), r = t.slice(0), u = +r[4], w = +r[5], v = {
                    matrix: t,
                    animate: "skip"
                };
                c = a.type;
                "pointerdown" === c ? (c = "pointermove",
                g = "pointerup") : "touchstart" === c ? (c = "touchmove",
                g = "touchend") : "MSPointerDown" === c ? (c = "MSPointerMove",
                g = "MSPointerUp") : (c = "mousemove",
                g = "mouseup");
                c += q;
                g += q;
                this.transition(!0);
                this._trigger("start", a, b);
                var x = function(a, b) {
                    if (b) {
                        if (2 === b.length) {
                            if (null != e)
                                return;
                            e = p._getDistance(b);
                            h = +t[0];
                            f = p._getMiddle(b);
                            return
                        }
                        if (null != k)
                            return;
                        if (m = b[0])
                            k = m.pageX,
                            l = m.pageY
                    }
                    null == k && (k = a.pageX || a.originalEvent.pageX,
                    l = a.pageY || a.originalEvent.pageY)
                };
                x(a, b);
                d(y).off(q).on(c, function(a) {
                    var c;
                    a.preventDefault();
                    b = a.touches || a.originalEvent.touches;
                    x(a, b);
                    if (b) {
                        if (2 === b.length) {
                            a = p._getMiddle(b);
                            c = p._getDistance(b) - e;
                            p.zoom(n.increment / 100 * c + h, {
                                focal: a,
                                matrix: t,
                                animate: "skip"
                            });
                            p.pan(+t[4] + a.clientX - f.clientX, +t[5] + a.clientY - f.clientY, v);
                            f = a;
                            return
                        }
                        c = b[0] || {
                            pageX: 0,
                            pageY: 0
                        }
                    }
                    c || (c = a);
                    p.pan(u + (c.pageX || c.originalEvent.pageX) - k, w + (c.pageY || c.originalEvent.pageY) - l, v)
                }).on(g, function(a) {
                    a.preventDefault();
                    d(this).off(q);
                    p.panning = !1;
                    a.type = "panzoomend";
                    p._trigger(a, t, !z(t, r))
                })
            }
        }
    };
    d.Panzoom = n;
    d.fn.panzoom = function(a) {
        var b, c, g, e;
        return "string" === typeof a ? (e = [],
        c = x.call(arguments, 1),
        this.each(function() {
            (b = d.data(this, "__pz__")) ? "_" !== a.charAt(0) && "function" === typeof (g = b[a]) && void 0 !== (g = g.apply(b, c)) && e.push(g) : e.push(void 0)
        }),
        e.length ? 1 === e.length ? e[0] : e : this) : this.each(function() {
            new n(this,a)
        })
    }
    ;
    return n
});
