function MK_check_bytes(str) {
    var l = 0;
    for (var i=0; i<str.length; i++) l += (str.charCodeAt(i)  > 128) ? 2 : 1;
    return l;
}

// 문자열 자르기
function cutchar(str, len) {
    //var str = this;
    var s = 0;
    if (str == '') return '';

    if (typeof str == 'undefined') {
        str = 0;
    }
    for (var i=0; i < str.length; i++) {
        s += (str.charCodeAt(i) > 128) ? 2 : 1;
        if (s > len) return str.substring(0, i) + "...";
    }
    return str;
}

function number_format(numid){
     var numstr = document.getElementById(numid).value;
     numstr = numstr.replace(/(,)/g,'');
     document.getElementById(numid).value = numstr.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1,');
}

function strip_tags(str, allow) {
    allow = (((allow || "") + "").toLowerCase().match(/<[a-z][a-z0-9]*>/g) || []).join('');

    var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi;
    var commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;
    return str.replace(commentsAndPhpTags, '').replace(tags, function (val0, val1) {
        return allow.indexOf('<' + val1.toLowerCase() + '>') > -1 ? val0 : '';
    });
}
function set_storage(key, value) {
    try {
        return sessionStorage.setItem(key, value);
    } catch (e) {
        return false;
    }
};
function get_storage(key) {
    try {
        return sessionStorage.getItem(key);
    } catch (e) {
        return false;
    }
};
function power_review_authimg(display) {
    if (display == 'block') {
        var passuid = '';
        if (typeof document.prw_form.authid != 'undefined') passuid = document.prw_form.authid.value;
        jQuery.ajax({
            type: 'POST',
            url: '/shop/authimg.html',
            dataType: 'html',
            async: false,
            data: {
                'passuid': passuid,
                'acmethod': 'power_review_submit',
                'formname': 'prw_form'
            },
            success: function(req) {
                var _x = (document.prw_form.offsetWidth / 2) - 155;
                var _y = (document.prw_form.offsetHeight / 2) - 50;
                jQuery('#pr_authimgdiv', '#writePowerReview').css({
                    'display': display,
                    'left': _x + 'px',
                    'top': _y + 'px'
                }).html(req);
                jQuery('#pr_authimgdiv', '#writePowerReview').parents('div').css({
                    'z-index': 2,
                    'zoom': 1
                });
            }
        });
        return false;
    }
    if (display == 'none') {
        document.prw_form.authtext.value = '';
        document.prw_form.authid.value = '';
        jQuery('#pr_authimgdiv').hide();
    }
}

function removeEmojis (string) {
    if (typeof window['emojiStrip'] === "function") {
        string = emojiStrip(string);
    }
    return string;
}

function power_review_authimg_mobile(display) {
    if (display == 'block') {
        var passuid='';
        var pars = 'passuid=' + passuid + '&acmethod=send&used_confirm_btn=Y&r='+Math.random();
        jQuery.ajax({
            type: 'POST',
            url: '/m/authimg.html',
            dataType: 'html',
            async: false,
            data: {
                'passuid': passuid,
                'acmethod': 'power_review_submit',
                'formname': 'pr_agrre',
                'used_confirm_btn': 'Y',
                'r': Math.random()
            },
            success: function(res) {
                var _x = (document.prw_form.offsetWidth / 2) - 155;
                jQuery('#pr_authimgdiv').css({
                    'display': display
                }).html(res);
            }
        });
    }
    if (display == 'none') {
        document.prw_form.authtext.value = '';
        document.prw_form.authid.value = '';
        jQuery('#pr_authimgdiv').hide();
    }
}
(function($) {
    window.power_review_pack = {
        info: {
            page_type   : '',
            config      : null,
            ordernum    : '',
            myordernum    : '',
            product_uid   : '',
            order_count : 0,
            order_key : 0,
            stand : null,
            list_lodding : false,
            list_first : true,
            location_dir : '/shop/'
        },
        set_page: function(page, config) {
           this.info.page_type = page; 
           this.info.config = config;
           this.info.location_dir = config.mobile_use == 1 ? '/m/' : '/shop/';
        },
        get_page: function() {
           return this.info.page_type;
        }
    }
    window.power_review_write = {
        init : function (action) {
            var config = power_review_pack.info.config;
            var page_type = power_review_pack.get_page();
            var _this = this;
            var _box , _form, _select_box, _content_box;

            if (action === 'update') {
                _box = $('#updatePowerReview');
                _form = $('#pru_form', _box);
            } else {
                _box = $('#writePowerReview');
                _form = $('#prw_form', _box);
            }
            
            config.board_auth_write_detail = config.board_auth_write;
            var e_text = '회원만 리뷰입력이 가능합니다.\n로그인 하시겠습니까?'; 
            if (config.board_auth_write == 'A' && config.board_review_write_type != 'NONE') {
                if (action != 'update' && page_type == 'product') {
                    e_text = '회원-로그인 / 비회원-주문조회 후 리뷰작성이 가능합니다.\n진행하시겠습니까?';
                    config.board_auth_write_detail = 'O';
                }
            }

            // TEXT AREA CLEAR
            if (action != 'update') {
                $('textarea[name=content]', _form).on({ 
                    "focus" : function() {
                        if (config.is_login === false && config.board_auth_write_detail != 'A') {
                            this.blur();
                            if (confirm(e_text)) {
                                document.location.href='/shop/member.html?type=shopdetail&branduid=' + config.product_uid;
                            }
                            return false;
                        }
                        var _box_w = $('#writePowerReview');
                        if ($('.pr-options', _box_w)) {
                            if (config.board_code == 'rptkd87_board2') {
                                $('.pr-options', _box_w).show();
                            } else {
                                $('.pr-options', _box_w).slideDown();
                            }
                        }
                        if (config.board_add_clearw  == 'Y') {
                            if ($(this).val() == $('textarea[name=board_writeword]', _form).val()) {
                                $(this).val('');
                            }
                        }
                    }, 
                    "blur" : function() {
                        if (config.board_add_clearw  == 'Y') {
                            if ($(this).val().length == 0) {
                                $(this).val($('textarea[name=board_writeword]', _form).val());
                            }
                        }
                    }, 
                    "paste cut change" : function() {
                        $(this).val(removeEmojis($(this).val()));
                        var str = strip_tags($(this).val()).replace(/&nbsp;/gi, ' ').replace(/&amp;/gi, '&').replace(/ /g, '').replace(/\n/g, '');
                        $('#PR_CONTENT_LENGTH').html(str.length);
                        if (page_type == 'product' && config.template_page_type !== '1') {
                            _content_box = this;
                            
                            setTimeout( function() {
                                $('textarea[name=content]', _form).css('height', 'auto' );
                                $('textarea[name=content]', _form).height( (_content_box.scrollHeight > 100 ? _content_box.scrollHeight : 100));
                            }, 10);
                        }
                    }, 
                    "keypress keydown" : function(e) {
                        if (removeEmojis(event.key) == '') {
                            return false;
                        }
                    }, 
                    "keyup" : function(e) {
                        var str = strip_tags($(this).val()).replace(/&nbsp;/gi, ' ').replace(/&amp;/gi, '&').replace(/ /g, '').replace(/\n/g, '');
                        $('#PR_CONTENT_LENGTH').html(str.length);
                    } 
                });
            } else {
                $('textarea[name=content]', _form).val(removeEmojis($('textarea[name=content]', _form).val()));
                var str = strip_tags($('textarea[name=content]', _form).val()).replace(/&nbsp;/gi, ' ').replace(/&amp;/gi, '&').replace(/ /g, '').replace(/\n/g, '');
                $('#PR_UPDATE_CONTENT_LENGTH').html(str.length);
                $('textarea[name=content]', _form).on({ 
                    "paste cut change" : function() {
                        var str = strip_tags($(this).val()).replace(/&nbsp;/gi, ' ').replace(/&amp;/gi, '&').replace(/ /g, '').replace(/\n/g, '');
                        $('#PR_UPDATE_CONTENT_LENGTH').html(str.length);
                    }, 
                    "keypress keydown" : function(e) {
                        if (removeEmojis(event.key) == '') {
                            return false;
                        }
                    }, 
                    "keyup" : function() {
                        var str = strip_tags($(this).val()).replace(/&nbsp;/gi, ' ').replace(/&amp;/gi, '&').replace(/ /g, '').replace(/\n/g, '');
                        $('#PR_UPDATE_CONTENT_LENGTH').html(str.length);
                    } 
                });
            }

            // 별점 열기 
            $('.star-list > a', _box).on('click', function(e) {
                e.preventDefault();
                $(this).closest('table').find('.star-list').css('z-index', '1');
                $(this).closest('.star-list').css('z-index', '10');
                $(this).siblings('ul').show();
                _this.selectbox_action($('.star-list', _box));

            });
            // 별점 선택/닫기
            $('.star-list ul li a', _box).on('click', function(e) {
                e.preventDefault();
                $('html').unbind('mousedown.modostar');
                $('.star-list', _box).unbind('mouseenter');
                $('.star-list', _box).unbind('mouseleave');
                
                var star_key = $(this).closest('.star-list').attr('star_key');
                if (!star_key) {
                    star_key = 1;
                }

                $('input[name=score' + star_key + ']', _form).val($('em', $(this)).html().length);
                $('> a', $(this).closest('.star-list')).html($(this).html());
                $(this).parent('li').parent('ul').hide();
            });

            if (config.mobile_use == 1) {
                $('.multi-score .sel-star > a', _box).on('click', function(e) {
                    var star_key = $(this).parent().attr('star_key');                    
                    var score = parseInt($(this).attr('score'));
                    $.each($(this).parent().children('a'), function() {
                        if (parseInt($(this).attr('score')) <= score) {
                            $(this).addClass('selected')
                        } else {
                            $(this).removeClass('selected')
                        }
                    });
                    $(this).parent().siblings('.txt').html($(this).attr('title'));
                    $('input[name=score' + star_key + ']', _form).val($(this).attr('score'));
                });
            }

            if (action != 'update') {
                // 리뷰 혜택 열기/닫기 
                $('.lnk-benefit', _box).on('mouseenter', function() {
                    $(this.hash).show();
                }).on('mouseleave', function() {
                    $(this.hash).hide();
                }).on('click', function(e) {
                    e.preventDefault();
                });
            } else {
                // 수정 레이어팝업 닫기 
                $('.close-layer', _box).on('click', function(e) {
                    e.preventDefault();
                    $(this.hash).hide();
                });
           }
            
            if (page_type == 'product' && config.template_page_type != '3') {
                if (config.template_page_type == '2') {
                    if ($('#powerReview .PR15N01-info').outerWidth() < 900) {
                        $('#powerReview .PR15N01-info').css('padding-right', '296x');
                        $('#powerReview .PR15N01-info .photo').css('width', '291px');
                    } else {
                        $('#powerReview .PR15N01-info').css('padding-right', '393px');
                        $('#powerReview .PR15N01-info .photo').css('width', '388px');
                    }
                } else {
                    if ($('#powerReview .info').outerWidth() < 900) {
                        $('#powerReview .info').css('padding-right', '263px');
                        $('#powerReview .info .photo').css('width', '258px');
                    } else {
                        $('#powerReview .info').css('padding-right', '349px');
                        $('#powerReview .info .photo').css('width', '344px');
                    }
                }
            }
            
            var fkey = 0;
            if (action == 'update') {
                if ($('input[name="old_file_name[]"]', _form) && $('input[name="old_file_name[]"]', _form).length > 0) {
                    fkey = $('input[name="old_file_name[]"]', _form).length - 1;
                }

                var f_count = $('input[name="old_file_name[]"]', _form) ? $('input[name="old_file_name[]"]', _form).length : 0;
                if (f_count < parseInt(config.board_attach_cnt)) {
                    $('.file-attach', _box).show();
                    if (page_type == 'product' && config.template_page_type !== '1') {
                        $('.pr-lnk-photo', _box).attr('href', '#none');
                    }
                } else {
                    $('.file-attach', _box).hide();
                    if (page_type == 'product' && config.template_page_type !== '1') {
                        $('.pr-lnk-photo', _box).attr('href', 'javascript:power_review_file_error();');
                    }
                }
            }
        
            var _ing_file = false;
            if (config.is_login === true || config.board_auth_write_detail == 'A') {
                var _fname = action == 'update' ? '#fileupload_update' : '#fileupload';
                var _add_protocol = '';
                if (typeof config.add_protocol != 'undefined') {
                    _add_protocol = config.add_protocol;
                }
                $(_fname, _box).fileupload({
                        url: config.board_host+'/upload.power_review.html',
                        type: 'POST',
                        forceIframeTransport: true,
                        redirect:'http' + _add_protocol + '://'+config.shopurl+'/shop/power_review_file_result.html',
                        dataType:'json',
                        start:function (e, data) {
                            _ing_file = true;
                        },
                        done: function (e, data) {
                            var d = data.result;
                            if (d && d.result === true && d.file_name && d.file_name.length > 0) {
                                fkey++;

                                _form.append('<input type="hidden" name="file_name[]" fkey="' + fkey + '" value="' + d.file_name + '">');
                                var _img_path = config.board_host + '/board/tmp/'+ config.file_board_code + ':mini::' + d.file_name; 

                                if (page_type == 'product' && config.template_page_type !== '1') {
                                    $('.thumb-wrap', _box).append('<a class="img btn-file-del cvr" fkey="' + fkey + '" href="javascript:power_review_del_file(\'' + action + '\', \'' + fkey + '\');"><span class="cover"></span><span class="cover-txt">삭제</span><img src="'+_img_path+'" alt="" /></a>');
                                } else if (config.mobile_use == 1) { 
                                    $('.file-attach', _box).after('<div class="btn-file-del cvr" fkey="' + fkey + '"><img class="bg" src="'+_img_path+'"><a class="cover" href="javascript:power_review_del_file(\'' + action + '\', \'' + fkey + '\');"><span>삭제</span></a></div>');
                                } else {
                                    $('.file-attach', _box).before('<div class="btn-file-del cvr" fkey="' + fkey + '"><img class="bg" src="'+_img_path+'"><a class="cover" href="javascript:power_review_del_file(\'' + action + '\', \'' + fkey + '\');"><span>삭제</span></a></div>');

                                }
                                var f_count = $('input[name="file_name[]"]', _form) ? $('input[name="file_name[]"]', _form).length : 0;

                                if (action == 'update') {
                                    f_count += $('input[name="old_file_name[]"]', _form) ? $('input[name="old_file_name[]"]', _form).length : 0;
                                }
                                if (f_count < parseInt(config.board_attach_cnt)) {
                                    $('.file-attach', _box).show();
                                    if (page_type == 'product' && config.template_page_type !== '1') {
                                        $('.pr-lnk-photo', _box).attr('href', '#none');
                                    }
                                } else {
                                    $('.file-attach', _box).hide();
                                    if (page_type == 'product' && config.template_page_type !== '1') {
                                        $('.pr-lnk-photo', _box).attr('href', 'javascript:power_review_file_error();');
                                    }
                                }

                            } else {
                                if (d && d.msg && d.msg.length > 0) {
                                    var msg = d.msg.replace(/\+/gi, ' ');
                                    alert(msg);
                                } else {
                                    alert("파일 업로드에 실패 했습니다. 다시 시도해 주세요.");
                                }
                            }
                            _ing_file = false;
                        }
                });
            } else {
                $('#fileupload').on('click', function(e) {
                    this.blur();
                    if (confirm(e_text)) {
                        document.location.href='/shop/member.html?type=shopdetail&branduid=' + config.product_uid;
                    }
                    return false;
                });
            }

            var prw_ing = false;
            _form.submit(function() {
                var _form = $(this);
                var _box_w = $('#writePowerReview');
                if (config.is_login === false  && config.board_auth_write_detail != 'A') {
                    this.blur();
                    if (confirm(e_text)) {
                        document.location.href='/shop/member.html?type=shopdetail&branduid=' + config.product_uid;
                    }
                    return false;
                }

                if (config.is_login === false && config.board_auth_write == 'A') {
                    if ($('input[name=hname]', _form).val().length == 0) {
                        alert("이름을 입력해 주세요.");                        
                        $('input[name=hname]', _form).focus();
                        return false;
                    }
                    if (action != 'update') {
                        if ($('input[name=passwd]', _form).val().length == 0) {
                            alert("비밀번호를 입력해 주세요.");                        
                            $('input[name=passwd]', _form).focus();
                            return false;
                        }
                    }
                    if (action != 'update') {
                        if ($('input[name=privercy_agree]', 'form[name=pr_agrre]') && $('input[name=privercy_agree]', 'form[name=pr_agrre]').length > 0) {
                            if ($("input[name='privercy_agree']:checked'", 'form[name=pr_agrre]').val() !== 'Y') {
                                alert("개인정보 수집.이용에 동의하신 후에 작성하실 수 있습니다.");
                                return false;
                            }
                        }
                    }
                }
                if (config.board_code == 'rptkd87_board2') {
                    $('.pr-options', _box_w).show();
                } else {
                    $('.pr-options', _box_w).slideDown();
                }
                if (config.board_add_clearw  == 'y') {
                    if ($(this).val() == $('textarea[name=board_writeword]', _form).val()) {
                        $(this).val('');
                    }
                }
                if (_ing_file == true) {
                    alert("파일을 업로드 중입니다. 잠시 후 다시 시도해 주세요.");
                    return false;
                }
                if (prw_ing === true) {
                    alert("리뷰를 작성 중입니다. 잠시만 기다려 주세요!");
                    return false;
                }
                prw_ing = true;
                if (config.board_add_clearw  == 'Y' && action != 'update') {
                    if ($('textarea[name=content]', _form).val() == $('textarea[name=board_writeword]', _form).val()) {
                        $('textarea[name=content]', _form).val('');
                    }
                }
                $.each($('input.pr-add-data', _form), function() {
                    if ($(this).attr('req') == 'Y' && $(this).attr('intype') == 'text') {
                        if ($(this).val().length == 0) {
                            alert($(this).attr('title') + '를(을) 입력해 주세요.');
                            $(this).focus();
                            prw_ing = false;
                            return false;
                        }
                        if ($(this).attr('intype').length > 0 && $(this).val().length > $(this).attr('limit')) {
                            alert($(this).attr('title') + '를(을) ' + $(this).attr('limit') + '자 이내로 입력해 주세요.');
                            $(this).focus();
                            prw_ing = false;
                            return false;
                        }
                    }
                    if ($(this).attr('intype') == 'checkbox') {
                        if ($(this).attr('req') == 'Y') {
                            if ($('input.pr_add_check_' + $(this).attr('aidx')+':checked', _form).length === 0) {
                                alert($(this).attr('title') + '를(을) 선택해 주세요.');
                                $(this).focus();
                                prw_ing = false;
                                return false;
                            }
                        }
                        var _cval = [];
                        $.each($('input.pr_add_check_' + $(this).attr('aidx')+':checked', _form), function() {
                            _cval.push($(this).val());
                        }); 
                        $(this).val(_cval.join(','));
                    }

                    if ($(this).attr('intype') == 'radio') {
                        if ($(this).attr('req') == 'Y') {
                            if ($('input[name="add_data[' + $(this).attr('aidx') + ']"]'+':checked', _form).length === 0) {
                                alert($(this).attr('title') + '를(을) 선택해 주세요.');
                                $(this).focus();
                                prw_ing = false;
                                return false;
                            }
                        }
                    }
                });
                if (prw_ing === false) {
                    return false;
                }
                $.each($('select.pr-add-data', _form), function() {
                    if ($(this).attr('req') == 'Y' && $(this).attr('intype') == 'select') {
                        if ($(this).val().length == 0) {
                            alert($(this).attr('title') + '를(을) 선택해 주세요.');
                            $(this).focus();
                            prw_ing = false;
                            return false;
                        }
                    }
                });
                if (prw_ing === false) {
                    return false;
                }
                $('textarea[name=content]', _form).val(removeEmojis($('textarea[name=content]', _form).val()));
                if ($('textarea[name=content]', _form).val().length === 0) {
                    alert("리뷰를 입력해 주세요.");
                    if ($('textarea[name=content]', _form).val().length == 0 && action != 'update') {
                        $('textarea[name=content]', _form).val($('textarea[name=board_writeword]', _form).val());
                    }
                    $('textarea[name=content]', _form).focus();
                    prw_ing = false;
                    return false;
                }

                var min_size = parseInt(config.board_min_length);
                if (_this.check_length(min_size, $('textarea[name=content]', _form).val()) === false) {
                    alert('리뷰는 ' + min_size + '글자 이상 입력하셔야 합니다.');
                    if ($('textarea[name=content]', _form).val().length == 0 && action != 'update') {
                        $('textarea[name=content]', _form).val($('textarea[name=board_writeword]', _form).val());
                    }
                    prw_ing = false;
                    return false;
                }
                var f_count = $('input[name="file_name[]"]', _form) ? $('input[name="file_name[]"]', _form).length : 0;
                if (action == 'update') {
                    f_count += $('input[name="old_file_name[]"]', _form) ? $('input[name="old_file_name[]"]', _form).length : 0;
                }
                if (config.board_photo_review_type == 'Y' && f_count == '0') {
                    alert('리뷰등록 시, 포토리뷰 등록은 필수입니다\n첨부파일을 등록해주시기 바랍니다.');
                    prw_ing = false;
                    return false;
                }
                if (action != 'update' && config.is_login === false && config.board_auth_write_detail == 'A') {
                    if (config.mobile_use == 1) {
                        if ($('#pr_authimgdiv', '#writePowerReview') && $('#pr_authimgdiv', '#writePowerReview').length > 0) {
                            if ($('input[name=authtext]', _form).length === 0) {
                                power_review_authimg_mobile('block');
                                prw_ing = false;
                                return false;
                            }
                        }
                        if ($('#pr_authimgdiv', '#writePowerReview').length > 0 && $('input[name=authtext]', _form).val().length == 0) {
                            alert("자동입력방지 문구를 입력해 주세요."); 
                            $('textarea[name=authtext]', _form).focus();
                            prw_ing = false;
                            return false;
                        }
                    } else {
                        if ($('#pr_authimgdiv', '#writePowerReview') && $('#pr_authimgdiv', '#writePowerReview').length > 0) {
                            if ($('input[name=authtext]', _form).length === 0 || $('input[name=authtext]', _form).val().length == 0) {
                                power_review_authimg('block');
                                prw_ing = false;
                                return false;
                            }
                        }
                    }
                }
                if (action == 'update') {
                    var num1 = $('input[name=num1]', _form).val();
                    var num2 = $('input[name=num2]', _form).val();
                }
                $(this).ajaxSubmit({
                    type : 'POST',
                    url  : power_review_pack.info.location_dir + 'power_review_write.action.html',
                    dataType: 'json',
                    success : function(response) {
                        if (response.success === true) {

                            var clear_date = new Date(); 
                            var clear_time = clear_date.getTime();
                            set_storage('power_review_clear_time', clear_time);

                            $('.btn-file-del', _box).remove();
                            $('input[name="file_name[]"]', _form).remove();
                            $('textarea[name=content]', _form).val($('textarea[name=board_writeword]', _form).val());

                            if (config.is_login === false) {
                                $('input[name=passwd]', _form).val('');
                                if (action !== 'update' && $('#pr_authimgdiv', '#writePowerReview') && $('#pr_authimgdiv', '#writePowerReview').length > 0) {
                                    if (config.mobile_use == 1) {
                                        power_review_authimg_mobile('none');
                                    } else {
                                        power_review_authimg('none');
                                    }
                                }
                            }

                            $('.file-attach', _box).show();

                            config.ordernum = '';

                            if (action !== 'update') {
                                $.each($('input.pr-add-data', _form), function(_i, _d) {
                                    $(this).val('');
                                });
                                $.each($('select.pr-add-data', _form), function(_i, _d) {
                                    $(this).val('');
                                });
                                $.each($('.pr-add-check', _form), function(_i, _d) {
                                    $(this).attr("checked", false);
                                });
                                $('#PR_CONTENT_LENGTH').html('0');
                            } else {
                                $('#PR_UPDATE_CONTENT_LENGTH').html('0');
                            }
                            
                            if (page_type == 'pop_write' || page_type == 'mypage_write') {
                                power_review_main.change_product('', '');
                                alert(response.message);
                            } else if (page_type == 'mp_review_write') {
                                alert(response.message);
                                document.location.reload();
                            }

                            if (page_type == 'product' || page_type == 'write' || page_type == 'update') {
                                if (action == 'update') {
                                    alert("수정되었습니다.");
                                    if (config.mobile_use && config.mobile_use == 1) {
                                        location.href = "/m/power_review_view.html?product_uid=" + config.product_uid + "&num1=" + num1+ "&num2=00000";
                                    } else {
                                        $('#layerReviewModify').hide();
                                        power_review_list.get_list('', '');
                                    }
                                } else {
                                    if (response.data.use_write == 'N') {
                                        $('#writePowerReview').hide();
                                    }
                                    if (config.mobile_use != 1) {
                                        power_review_list.get_list(1, '');
                                    }

                                    alert(response.message);


                                    // 모바일 후기 페이지로 이동
                                    if (config.mobile_use && config.mobile_use == 1) {
                                        if (config.ref_page && config.ref_page == 'unregist') {
                                            location.href = "/m/power_review_unregist_review.html?reg_uid=" + config.product_uid;
                                        } else {
                                            location.href = "/m/power_review_product.html?product_uid=" + config.product_uid;
                                        }
                                    }
                                }
                            }
                        } else {
                            if (action !== 'update' && config.is_login === false) {
                                if (config.mobile_use == 1) {
                                    if ($('#pr_authimgdiv', '#writePowerReview') && $('#pr_authimgdiv', '#writePowerReview').length > 0) {
                                        power_review_authimg_mobile('block');
                                    }
                                } else {
                                    if ($('#pr_authimgdiv', '#writePowerReview') && $('#pr_authimgdiv', '#writePowerReview').length > 0) {
                                        power_review_authimg('none');
                                    }
                                }
                            }
                            alert(response.message);
                        }
                        prw_ing = false;
                    }
                });
                return false;
            });
        },
        selectbox_action: function(_ob) {
            power_review_write._select_box = _ob;
            _ob.on('mouseleave', function(e) {
                $(this).unbind('mouseleave');

                $(this).on('mouseenter', function(e) {
                    $(this).unbind('mouseenter');
                    $("html").unbind('mousedown.modostar');
                    power_review_write.selectbox_action($(this));
                });                
                $("html").on('mousedown.modostar', function(e) {
                    $(this).unbind('mousedown.modostar');
                    power_review_write._select_box.unbind('mouseenter');
                    $('ul', power_review_write._select_box).hide(); 
                }); 
            });                

        },
        check_length: function(size, v, ki) {
            var str = strip_tags(v).replace(/&nbsp;/gi, ' ').replace(/&amp;/gi, '&').replace(/ /g, '').replace(/\n/g, '');
            messlength = str.length;
            if (ki == 'max') {
                if (messlength > size) {
                     return false;
                }
            } else {
                if (messlength < size) {
                     return false;
                }
            }
            return true;
        },
        del_file : function (action, k) {
            var config = power_review_pack.info.config;
            if (action === 'update') {
                _box = $('#updatePowerReview');
                _form = $('#pru_form', _box);
            } else {
                _box = $('#writePowerReview');
                _form = $('#prw_form', _box);
            }
            
            $('input[fkey='+k+']', _form).remove();
            $('.cvr[fkey='+k+']', _box).remove();
            var f_count = $('input[name="file_name[]"]', _form) ? $('input[name="file_name[]"]', _form).length : 0;
            if (action == 'update') {
                f_count += $('input[name="old_file_name[]"]', _form) ? $('input[name="old_file_name[]"]', _form).length : 0;
            }
            if (f_count < parseInt(config.board_attach_cnt)) {
                $('.file-attach', _box).show();
            }
        },
        like_product: function() {
            var page_type = power_review_pack.get_page();
            var _uid = null;
            if (power_review_pack.info.config.mobile_use == 1 && page_type == 'update') {
                _uid = $('input[name=product_uid]', '#pru_form');
            } else {
                _uid = $('input[name=product_uid]', '#prw_form');
            }
            if (!_uid || _uid.val().length === 0) {
                alert("상품정보가 없습니다.");
                return;
            }
            var param = 'action_type=like_product&product_uid=' + _uid.val() + '&page_type=' + page_type; 
            $.ajax({
                type : 'post',
                url  : power_review_pack.info.location_dir + 'power_review.action.html',
                data : param,
                dataType: 'json',
                success : function(response) {
                    if (response.success === true) {
                        if (power_review_pack.info.config.mobile_use == 1 && page_type == 'update') {
                            $('.cnt-like', '#updatePowerReview').html('+' + response.data);
                        } else if(page_type == 'pop_write') {
                            $('.cnt-like', '#POEWR_REVIEW_WRITE').html('+' + response.data);
                        } else {
                            $('.cnt-like', '#writePowerReview').html('+' + response.data);
                        }
                        return;
                    } else {
                        if (response.msg && response.msg.length > 0) {
                            alert(response.msg);
                        }
                        return;
                    }
                }
            });
        },
        write: function() {
            $('#prw_form').submit();
        }
    },
    window.power_review_main = {
        init : function () {
            var config = power_review_pack.info.config;
            var _this = this;

            // 메인팝업 닫기
            $('.close', '#popReview').on('click', function(e) {
                e.preventDefault();
                $(this).parents('#POEWR_REVIEW_WRITE').hide();
            });
            // 팁 열기/닫기
            $('.cvr-tip a', '#popReview').on('click', function(e) {
                e.preventDefault();
                $(this).parent().siblings('.tip').show();
                $(this).parent().siblings('.cvr-close').show();
                $(this).parent().hide();
            });
            $('.cvr-close a', '#popReview').on('click', function(e) {
                e.preventDefault();
                $(this).parent().siblings('.tip').hide();
                $(this).parent().siblings('.cvr-tip').show();
                $(this).parent().hide();
            });

            if (config.main_option_close == 'N') {
                var _box_w = $('#writePowerReview');
                $('.pr-options', _box_w).show();
            }

            if ($('.main_attach_image', '#popReview')) {
                if ($('.main_attach_image', '#popReview').width() < 1) {
                    setTimeout(function() {
                        power_review_main.resize_main_attach_image();
                    },500);
                } else {
                    power_review_main.resize_main_attach_image();
                }
            }

            config.set_stand_no = 0;
            if (config.sdata_json) {
                $.each(config.sdata_json, function(_i, _d) {
                    
                });
            }
        },
        resize_main_attach_image: function () {
            var config = power_review_pack.info.config;
            if ($('.main_attach_image', '#popReview')) {
                if (config.main_image_resize == 'width') {
                    if ($('.main_attach_image', '#popReview').width() > 338) {
                        $('.main_attach_image', '#popReview').css({'width' : '338px'});
                    }
                }
                if (config.main_image_resize == 'height') {
                    if ($('.main_attach_image', '#popReview').height() > 300) {
                        $('.main_attach_image', '#popReview').css({'height' : '300px'});
                    }
                }
                var _main_attach_image_top = (300 - $('.main_attach_image', '#popReview').height()) / 2
                var _main_attach_image_left = (338 - $('.main_attach_image', '#popReview').width()) / 2
                $('.main_attach_image', '#popReview').css({'top' : _main_attach_image_top + 'px', 'left' : + _main_attach_image_left + 'px' });
            }
        },
        close: function () {
            $('#POEWR_REVIEW_WRITE').hide();
        },
        mypage: function (ordernum, basketnum, uid) {
            var config = power_review_pack.info.config;
            var _skey = null; 
            var _this = this;
            if (config.order_count < 1) {
                alert("이미 모든 후기를 작성 하셨습니다.");
                return;
            }
            _this.change_product(ordernum, basketnum);
        },
        change_stand: function (p) {
            var config = power_review_pack.info.config;
            var _sidx = config.set_stand_no;
            _sidx = _sidx + p;
            if (_sidx < 0) {
                return false;
            }
            if (_sidx > config.sdata_json.length) {
                return false;
            }
            if (config.sdata_json[_sidx]) {
                $('.stand-order img', '#POEWR_REVIEW_WRITE').attr('src', config.sdata_json[_sidx].image_m);
                $('.stand-order a', '#POEWR_REVIEW_WRITE').attr('href', config.sdata_json[_sidx].link);
            }
            config.set_stand_no = _sidx;
        },
        change_product: function (ordernum, basketnum) {
            var config = power_review_pack.info.config;
            var _this = this;
            var param = 'action_type=change_product&ordernum=' + ordernum + '&basketnum=' + basketnum + '&my_ordernum=' + config.myordernum; 
            $.ajax({
                type : 'post',
                url  : power_review_pack.info.location_dir + 'power_review.action.html',
                data : param,
                dataType: 'json',
                success : function(response) {
                    if (response.success == true) {
                        response.html = decodeURIComponent(response.html);
                        $('#POEWR_REVIEW_WRITE').find('div').remove();
                        $.each($(response.html), function(_i, _d) {
                            if (_d.nodeName == 'DIV') {
                                $('#POEWR_REVIEW_WRITE').append($(this));
                            }
                        });
                        power_review_write.init('insert');
                        power_review_main.init();
                        $('#POEWR_REVIEW_WRITE').show();
                    } else {
                        if (ordernum != '' && response.msg && response.msg.length > 0) {
                            alert(response.msg);
                        }
                        $('#POEWR_REVIEW_WRITE').hide();
                    }
                }
            });
        },
        get_mp_write: function (ordernum, basketnum) {
            var config = power_review_pack.info.config;
            var _this = this;
            var param = 'action_type=change_product&no_view_today=Y&ordernum=' + ordernum + '&basketnum=' + basketnum + '&my_ordernum=' + ordernum;
            $.ajax({
                type : 'post',
                url  : power_review_pack.info.location_dir + 'power_review.action.html',
                data : param,
                dataType: 'json',
                success : function(response) {
                    if (response.success == true) {
                        response.html = decodeURIComponent(response.html);
                        $('#POEWR_REVIEW_WRITE').html(response.html);
                        power_review_write.init('insert');
                        power_review_main.init();

                        // 노출되는 위치를 잡아준다.
                        $('#POEWR_REVIEW_WRITE').css({'top': window.pageYOffset + 100 + 'px', 'left': window.innerWidth/2 + 'px'});
                        $('#POEWR_REVIEW_WRITE').show();
                    } else {
                        if (ordernum != '' && response.msg && response.msg.length > 0) {
                            alert(response.msg);
                        }
                        $('#POEWR_REVIEW_WRITE').hide();
                    }
                }
            });
        }
    },
    window.power_review_list = {
        data: {
            load_comment  : [],
            mod_data  : [],
            sort : '',
            page : 1,
            term : 1,
            category : '',
            photo : '',
            searchword : '',
            search_myreview : '',
            is_page_end : false
        },
        init : function () {
            var config = power_review_pack.info.config;
            var page_type = power_review_pack.get_page();
            var _this = this;
            // 댓글 가져올때는 안탐
            if (config.view_comment != 'Y') {
                _this.sort = '';
            }

            if (config.is_photo  && config.is_photo.length > 0) {
                _this.data.photo = config.is_photo;
            }

            if (config.template_page_type == '3') { 
                var photo_list_width = parseInt(config.photo_page_limit) * 75;
                $('#power_review_detail_photo').css({
                    'width': photo_list_width + 'px'
                });
            }

            // 댓글 바로보기시 아닌경우에만 해당 사용하도록
            if (config.info_comment_view == 'N') {
                // 리플 수정 레이어팝업 열기 
                $('.reply-wrap .ctr .modify', '#powerReview').on('click', function(e) {
                    e.preventDefault();
                    var _top = $(this).positon().top + 20;
                    $(this.hash).show().css({ 'top': _top });
                });
            }

            var comment_div = config.mobile_use && config.mobile_use == 1 ? '#viewPowerReview' : '#listPowerReview';
            $(comment_div).on({ 
                "focus" : function() {
                    if (config.is_login === false) {
                        this.blur();
                        if (confirm("회원만 댓글입력이 가능합니다.\n로그인 하시겠습니까?")) {
                            if (config.mobile_use && config.mobile_use == '1') {
                                document.location.href='/m/login.html?return_url=' + config.return_url;
                            } else {
                                document.location.href='/shop/member.html?type=shopdetail&branduid=' + config.product_uid;
                            }
                        }
                    }
                    if ($(this).val() == '댓글을 작성해 주세요~') {
                        $(this).val('');
                    }
                }, 
                "blur" : function() {
                    if ($(this).val().length == 0) {
                        $(this).val('댓글을 작성해 주세요~');
                    }
                } 
            }, 'textarea[name=comment]');

            // 레이어팝업 닫기 
            $('.lhd a', '#writeReview').on('click', function(e) {
                e.preventDefault();
                $('#overlay').hide();
                $(this.hash).hide();
            });

            // 수정 레이어팝업 닫기 
            $('.close-layer', '#layerReplyModify').on('click', function(e) {
                e.preventDefault();
                $(this.hash).hide();
            });
            $('form[name=prcp_form]').submit(function() {
                var num1 = $('input[name=num1]', 'form[name=prcp_form]').val();
                if ($('input[name=chk_type]', 'form[name=prcp_form]').val() == 'del') {
                    power_review_list.del_review(num1, 'in_pass');
                }
                if ($('input[name=chk_type]', 'form[name=prcp_form]').val() == 'update') {
                    power_review_list.update_review(num1, 'in_pass');
                }
                return false;
            });

            if (page_type == 'search' || page_type == 'photo_search' ) {
                // 공지사항 
                $('.pr-notice li.pr-q a').on('click', function(e) {
                    e.preventDefault();
                    if ($(this).parents('li').hasClass('pr-now')) {
                        $(this).parents('li').removeClass('pr-now').next('li.pr-a').slideUp();
                    } else {
                        if (config.board_code == 'rptkd87_board2') {
                            $(this).parents('li').addClass('pr-now').next('li.pr-a').show();
                        } else {
                            $(this).parents('li').addClass('pr-now').next('li.pr-a').slideDown();
                        }
                        if ($(this).attr('notice_no') && $(this).attr('notice_no') != '') {
                            var param = 'action_type=notice_hit&idx=' + $(this).attr('notice_no');
                            $.ajax({
                                type : 'post',
                                url  : power_review_pack.info.location_dir + 'power_review.action.html',
                                data : param,
                                dataType: 'json',
                                success : function(response) {
                                        return;
                                }
                            });
                        }
                    }

                });
                $('.pr-notice li.pr-a a.pr-close').on('click', function(e) {
                    e.preventDefault();
                    $(this).parents('li').slideUp().prev('li.pr-q').removeClass('pr-now');
                });
                if ($('input[name=chk_my]', 'form[name=prs_form]') && $('input[name=chk_my]', 'form[name=prs_form]').prop('checked') === true) {
                    power_review_list.data.search_myreview = 'Y';
                }
            }
            if (page_type == 'product') {
                if (config.product_uid != '') {
                    $('.photo-list a', '#listPowerReview').on('mouseover', function(e) {
                        if ($(this).siblings('.attach-preview').html() == '') {
                            $(this).clone().children('img').appendTo($(this).siblings('.attach-preview'));
                        }
                        $(this).parents('li.power-review-list-box').siblings('li').css('z-index', '1');
                        $(this).parents('li.power-review-list-box').css('z-index', '99');

                        $(this).siblings('.attach-preview').show();
                    });                   
                    $('.photo-list a', '#listPowerReview').on('mouseout', function(e) {
                            $(this).siblings('.attach-preview').hide();
                    });                   
                }
            }

            $('.close', '#layerChkPasswd').on('click', function(e) {
                e.preventDefault();
                $(this.hash).hide();
            });
        },
        review_chkpass: function() {
            var num1 = $('input[name=num1]', 'form[name=prcp_form]').val();
            if ($('input[name=chk_type]', 'form[name=prcp_form]').val() == 'del') {
                power_review_list.del_review(num1, 'in_pass');
            }
            if ($('input[name=chk_type]', 'form[name=prcp_form]').val() == 'update') {
                power_review_list.update_review(num1, 'in_pass');
            }
        },
        update: function() {
            $('#pru_form').submit();
        },
        update_review : function (num1, mode) {
            var config = power_review_pack.info.config;
            var page_type = power_review_pack.get_page();
            var chk_pass = '';

            var _tar = $('.modify', '#power_review_block' + num1);
            var _box = $('#power_review_block' + num1);
            var _this = this;

            // 비밀번호 확인창 
            if (mode == 'ch_view') {
                $('input[name=chk_type]', 'form[name=prcp_form]').val('update')
                $('input[name=num1]', 'form[name=prcp_form]').val(num1);
                $('input[name=passwd]', 'form[name=prcp_form]').val('');
                $('#layerChkPasswd').css({
                    'top': _box.position().top + _tar.position().top - 50 
                }).show();
                return false;
            }

            // 확인 비밀번호 전송
            if (mode == 'in_pass') {
                if ($('input[name=passwd]', 'form[name=prcp_form]').val().length == 0) {
                    alert("비밀번호를 입력해 주세요.");
                    $('input[name=passwd]', 'form[name=prcp_form]').focus();
                    return false;
                }
                chk_pass = $('input[name=passwd]', 'form[name=prcp_form]').val();
            }

            $.ajax({
                url: power_review_pack.info.location_dir + 'power_review.action.html?r=' + Math.random(),
                type: 'POST',
                dataType: 'json',
                data: {
                    action_type: 'get_review_update',
                    num1: num1,
                    passwd: chk_pass
                },
                success: function(response) {
                    if (response.success === true) {
                        $('#layerChkPasswd').hide();
                        $('input', 'form[name=prcp_form]').val('');

                        response.html = decodeURIComponent(response.html);
                        $('#updatePowerReview').html(response.html);
                        power_review_write.init('update');
                        $('#layerReviewModify').css({
                            'top': _box.position().top + _tar.position().top - 100 
                        }).show();
                    } else {
                        if (response.msg && response.msg.length > 0) {
                            alert(response.msg);
                        }
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    //alert('일시적인 오류로 인해 프로그램 수행을 중단합니다.\n다시 시도해 보시기 바랍니다.');
                }
            });
        },
        del_review: function (num1, mode) {
            var config = power_review_pack.info.config;
            var page_type = power_review_pack.get_page();
            var _this = this;
            var chk_pass = '';
            var _tar = $('.modify', '#power_review_block' + num1);
            var _box = $('#power_review_block' + num1);

            if (config.is_login === true) {
                if (confirm("리뷰를 삭제 하시겠습니까?") === false) {
                    return false;
                }
            } else {
                if (mode == 'ch_view') {

                    $('input[name=chk_type]', 'form[name=prcp_form]').val('del')
                    $('input[name=num1]', 'form[name=prcp_form]').val(num1);
                    $('#layerChkPasswd').css({
                        'top': _box.position().top + _tar.position().top - 50 
                    }).show();
                    return false;
                }
                if (mode == 'in_pass') {
                    if ($('input[name=passwd]', 'form[name=prcp_form]').val().length == 0) {
                        alert("비밀번호를 입력해 주세요.");
                        $('input[name=passwd]', 'form[name=prcp_form]').focus();
                        return false;
                    }
                    chk_pass = $('input[name=passwd]', 'form[name=prcp_form]').val();
                }
            }
            var _this = this;
            $.ajax({
                url: power_review_pack.info.location_dir + 'power_review.action.html?r=' + Math.random(),
                type: 'POST',
                dataType: 'json',
                data: {
                    action_type: 'del_review',
                    num1: num1,
                    passwd: chk_pass
                },
                success: function(response) {
                    if (response.success === true) {
                        var clear_date = new Date(); 
                        var clear_time = clear_date.getTime();
                        set_storage('power_review_clear_time', clear_time);

                        $('#layerChkPasswd').hide();
                        $('input', 'form[name=prcp_form]').val('');

                        _this.get_list(0, '');
                        alert("삭제 되었습니다.");
                    } else {
                        if (response.msg && response.msg.length > 0) {
                            alert(response.msg);
                        }
                        return;
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    //alert('일시적인 오류로 인해 프로그램 수행을 중단합니다.\n다시 시도해 보시기 바랍니다.');
                }
            });
        },
        click_more : function (num1) {
            var _box = $('#power_review_block' + num1);
            var config = power_review_pack.info.config;
            var page_type = power_review_pack.get_page();

            var content_simple = $('.pr-content-simple', _box);
            var content_all = $('.pr-content-all', _box);
            var content_option = $('.pr-options', _box);

            if (content_all) {
                content_simple.hide();
                content_all.show();
            }
            if (content_option) {
                content_option.show();
            }
            var content_p = $('.content_p', _box);
            if (content_option || content_p) {
                $('a.more-options', content_p).attr('href', 'javascript:power_review_more_close(\''+num1+'\');');
                $('a.pr-close', content_p).show();
            }
            var param = 'action_type=update_hit&num1=' + num1 + '&page_type='+page_type;
            $.ajax({
                type : 'post',
                url  : power_review_pack.info.location_dir + 'power_review.action.html',
                data : param,
                dataType: 'json',
                success : function(response) {
                        return;
                }
            });
        },
        click_more_close : function (num1) {
            var _box = $('#power_review_block' + num1);
            var config = power_review_pack.info.config;
            var page_type = power_review_pack.get_page();
            var content_simple = $('.pr-content-simple', _box);
            var content_all = $('.pr-content-all', _box);
            var content_option = $('.pr-options', _box);

            if (content_all) {
                content_simple.show();
                content_all.hide();
                content_option.hide();
                if (content_option.hasClass('on')) {
                    content_option.removeClass('on');
                }
            }
            var content_p = $('.content_p', _box);
            if (content_option || content_p) {
                $('a.more-options', content_p).attr('href', 'javascript:power_review_more(\''+num1+'\');');
                $('a.pr-close', content_p).hide();
            }
        },
        good_review: function (num1, old, page_type) {

            var _cookie = getCookie('power_review_good'); 
            page_type = page_type == 'view' ? page_type : power_review_pack.get_page();
            if (_cookie) {
                if (_cookie.indexOf('|' + num1 + '|') >= 0) {
                    alert("리뷰 추천은 1회만 가능합니다.");
                    return;
                } 
            }
            
            var _box = null;
            var _tar = null;
            if (page_type == 'product' || page_type == 'search') {
                _box = $('#power_review_block' + num1);
                _tar = $('.reply .yes span', _box);
            } else {
                _tar = $('.reply .yes span', '#viewPowerReview');
            }
            if (power_review_pack.info.config.mobile_use == 1 && page_type == 'view') {
                _tar = $('#viewPowerReview .reviewView .text span');

            }
            var param = 'action_type=good_review&num1=' + num1 + '&old=' + old + '&page_type=' + page_type;

            $.ajax({
                type : 'post',
                url  : power_review_pack.info.location_dir + 'power_review.action.html',
                data : param,
                dataType: 'json',
                success : function(response) {
                    if (response.success === true) {
                        _cookie = _cookie + '|' + num1 + '|';
                        setCookie('power_review_good', _cookie, 0);
                        _tar.html(response.data);
                        return;
                    } else {
                        if (response.msg && response.msg.length > 0) {
                            alert(response.msg);
                        }
                        return;
                    }
                }
            });
        },
        bad_review: function (num1, old, page_type) {

            page_type = page_type == 'view' ? page_type : power_review_pack.get_page();
            var _cookie = getCookie('power_review_good'); 
            if (_cookie) {
                if (_cookie.indexOf('|' + num1 + '|') >= 0) {
                    alert("리뷰 추천은 1회만 가능합니다.");
                    return;
                } 
            }
            
            var _box = null;
            var _tar = null;
            if (page_type == 'product' || page_type == 'search') {
                _box = $('#power_review_block' + num1);
                _tar = $('.reply .no span', _box);
            } else {
                _tar = $('.reply .no span', '#viewPowerReview');
            }
            var param = 'action_type=bad_review&num1=' + num1 + '&old=' + old + '&page_type=' + page_type;
            $.ajax({
                type : 'post',
                url  : power_review_pack.info.location_dir + 'power_review.action.html',
                data : param,
                dataType: 'json',
                success : function(response) {
                    if (response.success === true) {
                        _cookie = _cookie + '|' + num1 + '|';
                        setCookie('power_review_good', _cookie, 0);
                        _tar.html(response.data);
                        return;
                    } else {
                        if (response.msg && response.msg.length > 0) {
                            alert(response.msg);
                        }
                        return;
                    }
                }
            });
        },
        view_comment: function (num1, action) {
            var page_type = power_review_pack.get_page();
            var config = power_review_pack.info.config;
            var _box = null;
            var _tar = null;
            var _this = this;
            if (page_type == 'product' || page_type == 'search') {
                _box = $('#power_review_block' + num1);
                _tar = $('.reply-wrap', _box);
            } else if (page_type == 'view') {

            } else {
                _tar = $('.reply-wrap', '#viewpowerreview');
            }

            _list = _html = null;
            if (page_type == 'view') {
                _list = $('div.reply-list');
                _html = $('dl.reply-hidden').html();
            }else if (page_type == 'search') {
                _list = _tar;
                _html = $('li.block_comment', _box).html();
            } else {
                _list = $('ul.lst', _tar);
                _html = $('li.block_comment', _tar).html();
            }

            // PC에서만 처리
            var is_allow_comment_view = 'N';
            if (power_review_pack.info.config.mobile_use != 1) {
                if (config.info_comment_view == 'N' || (action != '' && config.info_comment_view == 'Y' && page_type == 'product')) {
                    is_allow_comment_view = 'Y';
                }
            } else {
                is_allow_comment_view = 'Y';
            }
            if ((($.inArray(num1, _this.data.load_comment) < 0 || action !== '') && config.board_code != 'review') && is_allow_comment_view == 'Y') {

                var write_time = '';
                if (get_storage('power_review_clear_time')) {
                    write_time = get_storage('power_review_clear_time');
                }

                $.ajax({
                    url: power_review_pack.info.location_dir + 'power_review.action.html',
                    type: 'GET',
                    dataType: 'json',
                    data: {
                        action_type: 'get_comment_list',
                        num1: num1,
                        page_type: page_type,
                        write_time: write_time
                    },
                    success: function(response) {
                        if (response.success === true) {
                            _this.data.load_comment.push(num1);
                            if (config.view_comment == 'Y') {
                                $('dl.reply', _list).remove();
                                if (response.data.list && response.data.list !== null) {
                                    $.each(response.data.list, function(_i, _d) {
                                        _thtml = _html;
                                        _d.comment = decodeURIComponent(_d.comment);
                                        _thtml = _thtml.replace('replace_comment', _d.comment);
                                        if (_d.link_mod.length > 0) {
                                            _thtml = _thtml.replace('replace_link_del', _d.link_del);
                                            _thtml = _thtml.replace('replace_btn', '');
                                        }
                                        _thtml = _thtml.replace('replace_btn', 'style="display:none"');
                                        _list.append('<dl class="reply" id="' + 'power_review_comment' + num1 + _d.uid +'">' + _thtml + '</dl>');
                                    });
                                }
                            } else {
                                $('li.cw', _list).remove();
                                if (response.data.list && response.data.list !== null) {
                                    $.each(response.data.list, function(_i, _d) {
                                        _thtml = _html;
                                        _d.comment = decodeURIComponent(_d.comment);
                                        _thtml = _thtml.replace('replace_comment', _d.comment);
                                        _thtml = _thtml.replace('replace_writer', _d.writer);
                                        _thtml = _thtml.replace('replace_date', _d.date);
                                        if (_d.link_mod.length > 0) {
                                            _thtml = _thtml.replace('replace_btn', '');
                                        }
                                        if (_i % 2 == 0) {
                                            _thtml = _thtml.replace('replace_icon', 'man');
                                        } else {
                                            _thtml = _thtml.replace('replace_icon', 'woman');
                                        }
                                        _thtml = _thtml.replace('replace_btn', 'style="display:none"');
                                        _list.append('<li class="cw" id="' + 'power_review_comment' + num1 + _d.uid +'">' + _thtml + '</li>');
                                        $('a.modify', '#power_review_comment' + num1 + _d.uid).attr('href', _d.link_mod);
                                        $('a.delete', '#power_review_comment' + num1 + _d.uid).attr('href', _d.link_del);
                                    });
                                }
                                if (action !== '') {
                                    $('.reply .cnt span', _box).html(response.data.total);
                                }
                            }
                            if (config.view_comment != 'Y') {
                                if (action !== '') {
                                    _tar.show();
                                } else {
                                    if (config.board_code != 'review') {
                                        _tar.toggle();
                                    }
                                }
                            }
                        } else {
                            if (response.msg && response.msg.length > 0) {
                                alert(response.msg);
                            }
                            return;
                        }
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        //alert('일시적인 오류로 인해 프로그램 수행을 중단합니다.\n다시 시도해 보시기 바랍니다.');
                    }

                });
            } else {
                if (config.view_comment != 'Y') {
                    if (action !== '') {
                        _tar.show();
                    } else {
                        if (config.board_code != 'review' || $('li.cw', _list).length > 0) {
                            _tar.toggle();
                        }
                    }
                }
            }

        },
        del_comment: function (num1, uid) {
            if (confirm("댓글을 삭제 하시겠습니까?") === false) {
                return;
            }

            var _this = this;
            $.ajax({
                url: power_review_pack.info.location_dir + 'power_review.action.html?r=' + Math.random(),
                type: 'POST',
                dataType: 'json',
                data: {
                    action_type: 'del_comment',
                    num1: num1,
                    uid: uid
                },
                success: function(response) {
                    if (response.success === true) {
                        _this.view_comment(num1, 'delete');
                        alert("삭제 되었습니다.");
                        if (power_review_pack.info.config.mobile_use == 1) {
                            document.location.reload();
                        }
                    } else {
                        if (response.msg && response.msg.length > 0) {
                            alert(response.msg);
                        }
                        return;
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    //alert('일시적인 오류로 인해 프로그램 수행을 중단합니다.\n다시 시도해 보시기 바랍니다.');
                }
            });
        },
        mod_comment: function (num1, uid) {
            var _this = this;
            _this.data.mod_data.num1 = num1;
            _this.data.mod_data.uid = uid;
            var _block = $('#power_review_block' + num1);
            var _box = $('#power_review_comment' + num1 + uid);

            $.ajax({
                type : 'POST',
                url  : power_review_pack.info.location_dir + 'power_review.action.html',
                data: {
                    action_type: 'get_comment',
                    num1: num1,
                    uid: uid
                },
                dataType: 'json',
                success : function(response) {
                    if (response.success === true) {
                        response.data = decodeURIComponent(response.data);
                        $('textarea', '#layerReplyModify').val(response.data);
                        $('#layerReplyModify').css({
                            'top': _box.position().top + _block.position().top 
                        }).show();
                        return;
                    } else {
                        if (response.msg && response.msg.length > 0) {
                            alert(response.msg);
                        }
                        return;
                    }
                }
            });

        },
        mod_comment_save: function () {
            var config = power_review_pack.info.config;
            var _comment = null;
            var _this = this;
            _comment = $('textarea[name=update_comment]', '#pruc_form');
            if (_comment && _comment.val().length === 0) {
                alert("댓글을 입력하세요");
                return;
            }
            var min_size = parseInt(config.board_comment_min_length);
            if (power_review_write.check_length(min_size, _comment.val()) === false) {
                alert('댓글은 ' +  min_size + '글자 이상 입력하셔야 합니다.');
                return;
            }
            var max_size = parseInt(config.board_comment_max_length);
            if (power_review_write.check_length(max_size, _comment.val(), 'max') === false) {
                alert('댓글은 ' +  max_size + '글자 이하로 입력하셔야 합니다.');
                return;
            }
            $.ajax({
                type : 'post',
                url  : power_review_pack.info.location_dir + 'power_review_comment.action.html',
                data: {
                    action_type: 'update',
                    num1: _this.data.mod_data.num1,
                    uid: _this.data.mod_data.uid,
                    comment: _comment.val()
                },
                dataType: 'json',
                success : function(response) {
                    if (response.success === true) {
                        _comment.val('');
                        _this.view_comment(_this.data.mod_data.num1, 'update');
                        $('#layerReplyModify').hide();
                        alert("수정 되었습니다.");
                        return;
                    } else {
                        if (response.message && response.message.length > 0) {
                            alert(response.message);
                        }
                        return;
                    }
                }
            });
        },
        change_sort : function (sort) {
            this.sort = sort;
            this.get_list(1, sort);
            var _val = sort.length > 0 ? sort : 'new';
            $('ul.sort > li', '#powerReview').removeClass('now');
            $('ul.sort > li[val='+_val+']', '#powerReview').addClass('now');
            document.location.href='#listPowerReview|list_sort='+sort;
        },
        change_page : function (page) {
            this.get_list(page, this.data.sort);
            document.location.href='#listPowerReview';
            document.location.href='#listPowerReview|page='+page+'|list_sort='+this.data.sort+'|list_term='+this.data.term;;
    
        },
        change_term : function (term) {
            this.get_list(1, this.data.sort, '', term);
            document.location.href='#listPowerReview';
            document.location.href='#listPowerReview|page=1|list_sort='+this.data.sort+'|list_term='+term;
    
        },
        get_list_type : function (type_btn, photo, nodata) {

            if (type_btn == 'division') {
                if (photo == 'Y') {
                    $('.pr-division-tab ul li', '#powerReview').first().addClass('now').siblings('li').removeClass('now');
                } else { 
                    $('.pr-division-tab ul li', '#powerReview').last().addClass('now').siblings('li').removeClass('now');
                }
            } else {
                if (photo == 'Y') {
                    $('.pr-photo-toggle > a', '#powerReview').addClass('now');
                } else { 
                    $('.pr-photo-toggle > a', '#powerReview').removeClass('now');
                }
            }
            if (nodata == 'Y') {
            } else {
                this.get_list(1, this.data.sort, '', '', photo);
            }
        },
        getUrlVars: function(){
            var vars = [], hash;
            var hashes = $(location).attr('hash').slice($(location).attr('hash').indexOf('#') + 1).split('|');
            for(var i = 0; i < hashes.length; i++)
            {
              hash = hashes[i].split('=');
              vars.push(hash[0]);
              vars[hash[0]] = hash[1];
            }
            return vars;
        },
        getUrlVar: function(name){
            return this.getUrlVars()[name];
        },
        get_list : function (page, sort, append, term, photo) {
            var config = power_review_pack.info.config;
            var page_type = power_review_pack.get_page();
            var _this = this;

            if (append == true && _this.data.is_page_end == true) {
                return false;
            }

            sort = sort == '' ? '' : sort;

            if (page === '') {
                var hash_page = this.getUrlVar('page');
                page = hash_page == '' || hash_page === undefined ? '1' : hash_page;

                var hash_term = this.getUrlVar('term');
                term = hash_term == '' || hash_term === undefined ? '1' : hash_term;
            } else {
                page = page;
            }

            if (!term) {
                term = this.data.term;
            }
            if (!photo) {
                photo = this.data.photo;
            }
            photo = photo == 'A' ? '' : photo;

            this.data.page = page;
            this.data.sort = sort;
            this.data.term = term;
            this.data.photo = photo;

            var category = this.data.category;
            var searchword = this.data.searchword;
            var search_myreview = this.data.search_myreview;
            var location_dir = config.mobile_use == 1 ? '/m/' : '/shop/';

            var write_time = '';
            if (get_storage('power_review_clear_time')) {
                write_time = get_storage('power_review_clear_time');
            }

            $.ajax({
                url: power_review_pack.info.location_dir + 'power_review.action.html',
                type: 'GET',
                dataType: 'json',
                data: {
                    action_type: 'get_review_list',
                    page_type: page_type,
                    product_uid: config.product_uid,
                    page: page,
                    sort: sort,
                    term: term,
                    is_photo: photo,
                    category: category,
                    searchword: searchword,
                    search_myreview: search_myreview,
                    write_time: write_time
                },
                success: function(response) {
                    response.html = decodeURIComponent(response.html);
                    _this.data.is_page_end = response.is_page_end;
                    if (page_type == 'photo_search') { 
                        try {
                            var $add = $(response.html) ? $(response.html) : '';
                        } catch (e) {
                            var $add = '';
                        }
                        if (config.set_photo_list_page == 'PAGING') {
                            $('#PowerReviewPhoto').html($add);
                            $('#listPowerReview').masonry({
                                  itemSelector: '.grid-item',
                                  columnWidth : 190,
                                  isAnimated: true
                            });
                        } else {
                            if (append == true) { 
                                $('#listPowerReview').append($add).masonry( 'appended', $add, true);
                            } else {
                                $('#listPowerReview').html($add).masonry( 'reload');
                            }
                        }
                    } else {
                        _this.data.load_comment = [];

                        if (page_type == 'search' && config.set_board_list_page == 'SCROLL' && append == true) {
                            $('#listPowerReview').append(response.html);
                        } else {
                            $('#listPowerReview').html(response.html);
                        }

                        if (config.product_uid != '') {

                            $('.photo-list a', '#listPowerReview').on('mouseover', function(e) {
                                if ($(this).siblings('.attach-preview').html() == '') {
                                    $(this).clone().children('img').appendTo($(this).siblings('.attach-preview'));
                                }
                                $(this).parents('li,power-review-list-box').siblings('li').css('z-index', '1');
                                $(this).parents('li.power-review-list-box').css('z-index', '99');
                                $(this).siblings('.attach-preview').show();

                            });                   
                            $('.photo-list a', '#listPowerReview').on('mouseout', function(e) {
                                    $(this).siblings('.attach-preview').hide();
                            });                   
                        }
                    }
                    power_review_pack.info.list_lodding = false;
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    //alert('일시적인 오류로 인해 프로그램 수행을 중단합니다.\n다시 시도해 보시기 바랍니다.');
                    power_review_pack.info.list_lodding = false;
                }
            });
        },
        write_comment: function (num1) {
            var config = power_review_pack.info.config;
            var page_type = power_review_pack.get_page();
            var _comment = null;
            var _this = this;
            if (page_type == 'product') {
                _comment = $('textarea[name=comment]', '#power_review_block' + num1);
            } else {
                _comment = $('textarea[name=comment]', '#viewPowerReview');
            }
            if (_comment.val() == '댓글을 작성해 주세요~') {
                alert("댓글을 입력하세요");
                return;
            }
            if (_comment && _comment.val().length === 0) {
                alert("댓글을 입력하세요");
                return;
            }
            var min_size = parseInt(config.board_comment_min_length);
            if (power_review_write.check_length(min_size, _comment.val()) === false) {
                alert('댓글은 ' + min_size + "글자 이상 입력하셔야 합니다.");
                return;
            }
            var max_size = parseInt(config.board_comment_max_length);
            if (power_review_write.check_length(max_size, _comment.val(), 'max') === false) {
                alert('댓글은 ' +  max_size + '글자 이하로 입력하셔야 합니다.');
                return;
            }
            $.ajax({
                type : 'post',
                url  : power_review_pack.info.location_dir + 'power_review_comment.action.html',
                data: {
                    action_type: 'good_review',
                    num1: num1,
                    comment: _comment.val()
                },
                dataType: 'json',
                success : function(response) {
                    if (response.success === true) {
                        var clear_date = new Date(); 
                        var clear_time = clear_date.getTime();
                        set_storage('power_review_clear_time', clear_time);

                        _comment.val('');
                        _this.view_comment(num1, 'insert');
                        alert("등록되었습니다.");
                        return;
                    } else {
                        if (response.message && response.message.length > 0) {
                            alert(response.message);
                        }
                        return;
                    }
                }
            });
        },
        change_photo_list : function (add) {
            var config = power_review_pack.info.config;
            if (config === null) {
                return;
            }
            if (config.photo_total_page < 1) {
                return;
            }
            config.page_photo = config.page_photo ? config.page_photo : 1;
            if (config.page_photo + add < 1) {
                return false;
            }
            if (config.page_photo + add > config.photo_total_page) {
                return false;
            }
            if (config.photo_total_page + add < 1) {
                return false;
            }
            config.page_photo += add;
            var list = $('#power_review_detail_photo').children();
            if (list.length > 0) {
                var clone = $(list[0]).clone();
                var _tmp_clone;
                $.ajax({
                    url: '/shop/power_review.action.html?r=' + Math.random(),
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        action_type: 'get_detail_photo_review',
                        uid: config.product_uid,
                        page: config.page_photo
                    },
                    success: function(response) {
                        if (response.success === true) {
                            var _html = '';
                            $('#power_review_detail_photo').html('');
                            if (response.data.list && response.data.list !== null) {
                                $.each(response.data.list, function(_i, _d) {
                                    _tmp_clone = clone.clone();
                                    _d.attach_square = decodeURIComponent(_d.attach_square);
                                    _tmp_clone.find('img').attr('src', _d.attach_square);
                                    _tmp_clone.find('a').attr('href', _d.link);
                                    _tmp_clone.find('img').unbind('load').load(function() {
                                        $(this).show();
                                    });
                                    $('#power_review_detail_photo').append(_tmp_clone);
                                });
                            }
                        }
                    }
                });
            }
        },
        change_best_list : function (add) {
            var config = power_review_pack.info.config;
            if (config === null) {
                return;
            }
            if (config.best_total_page < 1) {
                return;
            }
            config.page_best = config.page_best ? config.page_best : 1;
            if (config.page_best + add < 1) {
                return false;
            }
            if (config.page_best + add > config.best_total_page) {
                return false;
            }
            if (config.best_total_page + add < 1) {
                return false;
            }
            config.page_best += add;
            var list = $('#power_review_detail_best').children();
            if (list.length > 0) {
                var clone = $(list[0]).clone();
                var _tmp_clone;
                $.ajax({
                    url: '/shop/power_review.action.html?r=' + Math.random(),
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        action_type: 'get_detail_best_review',
                        uid: config.product_uid,
                        page: config.page_best
                    },
                    success: function(response) {
                        if (response.success === true) {
                            var _html = '';
                            $('#power_review_detail_best').html('');
                            if (response.data.list && response.data.list !== null) {
                                $.each(response.data.list, function(_i, _d) {
                                    _tmp_clone = clone.clone();

                                    _d.attach_square = decodeURIComponent(_d.attach_square);
                                    _tmp_clone.find('img').attr('src', _d.attach_square);
                                    _tmp_clone.find('a').attr('href', _d.link);
                                    _tmp_clone.find('img').unbind('load').load(function() {
                                        $(this).show();
                                    });
                                    $('#power_review_detail_best').append(_tmp_clone);
                                });
                            }
                        }
                    }
                });
            }
        }
    },
    window.power_review_view = {
        data: {
            attach_list  : []
        },
        init : function () {
            $('#viewPowerReview').popup();
        },
        close: function () {
            $('#viewPowerReview').popup('hide');
        },
        close_img : function () {
            $('#zoomPowerReviewIMG').popup('hide');
        },
        close_img_end : function () {
            setTimeout(function() {
                $('#viewPowerReview').popup('show');
            }, 20);
        },
        zoom_img : function () {
            $('#viewPowerReview').popup('hide');
            $('#zoomPowerReviewIMG').html($('#viewPowerReview .view_attach_image').parent().html());
            $('#zoomPowerReviewIMG .view_attach_image').css ({
                width: 'auto',
                height: 'auto'
            });
            $('#zoomPowerReviewIMG').popup('reposition');

            setTimeout(function() {
                $('#zoomPowerReviewIMG').popup('show');
            }, 20);

        },
        show : function (num1, num2, fidx, area) {
            var config = power_review_pack.info.config;
            var page_type = power_review_pack.get_page();
            var _product_uid = config == null ? '' : config.product_uid;
            var _this = this;
            if (area == 'main_list') {
                var main_config = {
                    mobile_use : false,
                    board_code : ''
                };
                power_review_pack.info.config = main_config;
                config = main_config;
            }


            var sort = sort == '' ? '' : sort;
            $.ajax({
                url: power_review_pack.info.location_dir + 'power_review.action.html',
                type: 'GET',
                dataType: 'json',
                data: {
                    action_type: 'get_review_view',
                    product_uid: _product_uid,
                    num1: num1,
                    num2: num2,
                    fidx: fidx,
                    area: area,
                    list_category: power_review_list.data.category,
                    list_sort: power_review_list.data.sort,
                    list_searchword: power_review_list.data.searchword,
                    list_page: power_review_list.data.page
                },
                success: function(response) {
                    response.html = decodeURIComponent(response.html);
                    _this.data.attach_list = response.attach_list;
                    if ($('#viewPowerReview').length > 0) {
                        $.each($(response.html), function(_i, _d) {
                            if (_d.nodeName == 'DIV') {
                                $('#viewPowerReview').append(response.html);
                                $('#viewPowerReview').html($(this).html());
                            }
                        });
                    } else {
                        $('body').append(response.html);
                    }
                    $('.pr_move_left', '#viewPowerReview').hide();
                    $('.pr_move_right', '#viewPowerReview').hide();
                    if (config.board_code && config.board_code == 'farmtail_board4') {
                        $('#viewPowerReview').popup({
                            blur:false
                        });
                    }                    
                    $('#viewPowerReview').popup('show');
                    $('#viewPowerReview').popup('reposition');
                    if ($('#viewPowerReview').width() - 150 > $('div.review', '#viewPowerReview').width()) {
                        $('div.review', '#viewPowerReview').width($('#viewPowerReview').width() - 150);
                    }
                    if (area == 'board_photo') {
                        setTimeout(function() {
                        var btn_top = ($(window).height() / 2) - ($('#viewPowerReview').position().top + parseInt($('#viewPowerReview').css('margin-top').replace('px',''))) - 20;

                        $('.pr_move_left', '#viewPowerReview').css({
                                top: btn_top + 'px'

                        })
                        $('.pr_move_left', '#viewPowerReview').show();
                        $('.pr_move_right', '#viewPowerReview').css({
                                top: btn_top + 'px'
                        })
                        $('.pr_move_right', '#viewPowerReview').show();
                        }, 50);
                    }
                    $('#zoomPowerReviewIMG').unbind();
                    $('.link-attach-image', '#viewPowerReview').unbind();
                    if ($('.view_attach_image', '#viewPowerReview') && ($('.view_attach_image', '#viewPowerReview').width() >= 900 || $('.view_attach_image', '#viewPowerReview').height() >= 600)) {
                        $('.link-attach-image', '#viewPowerReview').on('click', function(e) {
                            power_review_view.zoom_img();
                        });
                        $('.link-attach-image', '#viewPowerReview').addClass('zoom-attach-image');
                        $('#zoomPowerReviewIMG').popup({
                            closetransitionend: function() {
                                power_review_view.close_img_end();
                            }
                        });
                        $('#zoomPowerReviewIMG').on('click', function(e) {
                            power_review_view.close_img();
                        });
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    //alert('일시적인 오류로 인해 프로그램 수행을 중단합니다.\n다시 시도해 보시기 바랍니다.');
                }
            });
        },
        change : function (num1, num2, fidx, area) {
            var config = power_review_pack.info.config;
            var page_type = power_review_pack.get_page();
            var _this = this;
            var view_attach_image = $('#viewPowerReview .view_attach_image');
            if (view_attach_image && view_attach_image.length > 0) {
                // 첨부파일 이미지 리사이징 처리
                var max_width  = 900; // 첨부파일 가로 이미지 최대크기
                var max_height = 600; // 첨부파일 세로 이미지 최대크기
                var tmp_width  = _this.data.attach_list[fidx].origin_image_width;
                var tmp_height = _this.data.attach_list[fidx].origin_image_height;


                $( "#viewPowerReview" ).fadeTo('fast', 0.001, function() {
                    view_attach_image.attr('src', _this.data.attach_list[fidx].origin_image);
                    view_attach_image.unbind('load').load(function() {


                    if (tmp_width >= max_width || tmp_height >= max_height) {
                        var t_width  = max_width / tmp_width;
                        var t_height = max_height / tmp_height;

                        if (t_width < t_height) {
                            _this.data.attach_list[fidx].origin_image_width  = max_width;
                            _this.data.attach_list[fidx].origin_image_height = Math.floor(tmp_height * t_width);
                        } else {
                            _this.data.attach_list[fidx].origin_image_height = max_height;
                            _this.data.attach_list[fidx].origin_image_width  = Math.floor(tmp_width * t_height);
                        }
                    }

                    view_attach_image.css({
                        height : _this.data.attach_list[fidx].origin_image_height + 'px',
                        width  : _this.data.attach_list[fidx].origin_image_width + 'px'
                    });
                    $('#viewPowerReview').popup('reposition');
                        $('#viewPowerReview').fadeTo( "fast", 1);
                    });
                });
                
                if (tmp_width >= max_width || tmp_height >= max_height) {
                    $('.link-attach-image', '#viewPowerReview').on('click', function(e) {
                        power_review_view.zoom_img();
                    });
                    $('.link-attach-image', '#viewPowerReview').addClass('zoom-attach-image');
                    $('#zoomPowerReviewIMG').popup({
                        closetransitionend: function() {
                            power_review_view.close_img_end();
                        }
                    });
                    $('#zoomPowerReviewIMG').on('click', function(e) {
                        power_review_view.close_img();
                    });
                } else {
                    $('.link-attach-image', '#viewPowerReview').removeClass('zoom-attach-image');
                    $('.link-attach-image', '#viewPowerReview').unbind('click');
                    $('#zoomPowerReviewIMG').unbind();
                }

                $.each($('#viewPowerReview .pagination a'), function(_i, _d) {
                    $(this).removeClass('now');
                    if (_i == fidx) {
                        $(this).addClass('now');
                    }
                });
            }
        }
    },
    window.power_review_search = {
        init : function () {
            var _select_box;
            var _this = this;

            var page_type = power_review_pack.get_page();
            var config = power_review_pack.info.config;
            if (page_type == 'photo_search') {
                power_review_list.data.is_page_end = config.is_page_end; 
                if (config.set_photo_list_page != 'PAGING') {
                    $(window).scroll(function(){  
                        if (power_review_pack.info.list_lodding === false) {
                            if  ($(window).scrollTop() > $('#listPowerReview').offset().top + $('#listPowerReview').height() - $(window).height()){  
                                power_review_pack.info.list_lodding = true;
                                power_review_list.get_list(parseInt(power_review_list.data.page) + 1, power_review_list.data.sort, true);
                            }  
                        }
                    });  
                }
                $('#listPowerReview').masonry({
                      itemSelector: '.grid-item',
                      columnWidth : 190,
                      isAnimated: true
                });

                // 상품 마우스 오버/아웃
                $('#listPowerReview').on({
                       'click' :  function(e) {
                            $('#listPowerReview').masonry( 'remove',  $(this).parents('.grid-item')).masonry( 'reload' );
                            if (power_review_pack.info.list_lodding === false) {
                                if  ($(window).scrollTop() > $('#listPowerReview').offset().top + $('#listPowerReview').height() - $(window).height()){  
                                    power_review_pack.info.list_lodding = true;
                                    power_review_list.get_list(parseInt(power_review_list.data.page) + 1, power_review_list.data.sort, true);
                                }  
                            }
                        }
                }, '.PR15N01-review li > a.close');

                // 상품 마우스 오버/아웃
                $('#listPowerReview').on({
                       'mouseenter' :  function(e) {
                            $(this).find('.close').show();
                            $(this).find('dl').css({'border': '2px solid #000'});
                        },
                        'mouseleave' :  function(e) {
                            $(this).find('.close').hide();
                            $(this).find('dl').css({'border': '2px solid #ebebeb'});
                        }
                }, '.PR15N01-review li');

            }
            if (page_type == 'search') {
                power_review_list.data.is_page_end = config.is_page_end; 
                if (config.set_board_list_page == 'SCROLL') {
                    $(window).scroll(function(){  
                        if (power_review_pack.info.list_lodding === false) {
                            if  ($(window).scrollTop() > $('#listPowerReview').offset().top + $('#listPowerReview').height() - $(window).height()){  
                                power_review_pack.info.list_lodding = true;
                                power_review_list.get_list(parseInt(power_review_list.data.page) + 1, power_review_list.data.sort, true);
                            }  
                        }
                    });  
                }

            }
            $('form[name=prs_form]').submit(function() {
                power_review_list.data.searchword = $('input[name=search_word]', $(this)).val();
                power_review_list.get_list('1', power_review_list.data.sort);
                return false; 
            });
            // 셀렉트박스 열기 
            $('.frm .lst > a').on('click', function(e) {
                e.preventDefault();
                $(this).siblings('.cover').show();
                _this.selectbox_action($(this).parent('.lst')); 
            });
            // 셀렉트박스 선택/닫기
            $('.frm .category').on({
                   'click' :  function(e) {
                        e.preventDefault();

                        $('html').unbind('mousedown.modostar');
                        $('.frm .category').unbind('mouseenter');
                        $('.frm .category').unbind('mouseleave');

                        $(this).parents('.cover').siblings('.lst > a').html($(this).html());
                        $(this).parents('.cover').hide();

                        if ($(this).attr('code') == 'no') {
                            return;
                        }
                        // get list
                        power_review_list.data.category = $(this).attr('code');
                        power_review_list.get_list('1', power_review_list.data.sort);
                        // 하위분류 SELECT
                        power_review_search.get_category_list(power_review_list.data.category, $(this).attr('all'));
                    }
            }, 'ul li a');
            $('.frm .sort ul li a').on('click', function(e) {
                e.preventDefault();

                $('html').unbind('mousedown.modostar');
                $('.frm .category').unbind('mouseenter');
                $('.frm .category').unbind('mouseleave');

                power_review_list.change_sort($(this).attr('code'));
                $(this).parents('.cover').siblings('.lst > a').html($(this).html());
                $(this).parents('.cover').hide();
            });                   
            $('.frm .rtype ul li a').on('click', function(e) {
                e.preventDefault();

                $('html').unbind('mousedown.modostar');
                $('.frm .category').unbind('mouseenter');
                $('.frm .category').unbind('mouseleave');

                power_review_list.get_list('1', $(this).attr('code'));
                $(this).parents('.cover').siblings('.lst > a').html($(this).html());
                $(this).parents('.cover').hide();
            });                   
            $('input[name=chk_my]', 'form[name=prs_form]').on('change', function(e) {
                power_review_list.data.search_myreview = $(this).prop('checked') === true ? $(this).val() : '';
                power_review_list.get_list('1', power_review_list.data.sort);
            });                   
        },
        get_category_list_select : function(code, all) {
            var type = code.substring(0, 1);
            var xcode = code.substring(1, 4);
            var mcode = code.substring(4, 7);
            var scode = code.substring(7, 10);
            var all = all ? all : '';

            var _1st = $('.pr-search-cate1 > .cover > ul', '.frm-category-sort');
            var _2st = $('.pr-search-cate2 > .cover > ul', '.frm-category-sort');
            var _3st = $('.pr-search-cate3 > .cover > ul', '.frm-category-sort');
            var _opt = [];

            if (code == 'no' || scode != '' || !_2st || (mcode != '' && !_3st)) {
                return false;
            }

            if (xcode == '') {
                _2st.empty();
                _3st.empty();
                $('.pr-search-cate2 > .pr-cate-sel > span', '.frm-category-sort').html('중분류');
                $('.pr-search-cate3 > .pr-cate-sel > span', '.frm-category-sort').html('소분류');
                return false;
            }

            $.ajax({
                type : 'post',
                url  : power_review_pack.info.location_dir + 'category.html',
                data : { xcode: xcode, mcode: mcode },
                dataType: 'json',
                success : function(response) {
                    if (response.success === true) {
                        if (mcode == '') { 
                            _2st.empty().append('<li><a href="#none" code="' + type + xcode + '" all="Y"><span>중분류 전체</span></a></li>')
                            _3st.empty();
                            if (all == '') {
                                $('.pr-search-cate2 > .pr-cate-sel > span', '.frm-category-sort').html('중분류');
                            }
                            $('.pr-search-cate3 > .pr-cate-sel > span', '.frm-category-sort').html('소분류');
                        }
                        if (mcode != '') { 
                            _3st.empty().append('<li><a href="#none" code="' + type + xcode + mcode + '" all="Y"><span>소분류 전체</span></a></li>')
                            if (all == '') {
                                $('.pr-search-cate3 > .pr-cate-sel > span', '.frm-category-sort').html('소분류');
                            }
                        }
                        $.each(response.category, function(key, val) {
                            var _code = mcode == '' ? type + xcode + val.mcode : type + xcode + mcode + val.scode;
                            _opt.push('<li><a href="#none" code="' + _code + '"><span>' + val.codename + '</span></a></li>');
                        });
                        if (_opt.length > 0) {
                            if (mcode == '') {
                                _2st.append(_opt.join(''));
                            } else {
                                _3st.append(_opt.join(''));
                            }
                        } else {
                            if (mcode == '') { 
                                _2st.empty().append('<li><a href="#none" code="no"><span>중분류 없음</span></a></li>')
                            }
                            if (mcode != '') { _3st.empty().append('<li><a href="#none" code="no"><span>소분류 없음</span></a></li>')}
                        }
                    }
                }
            });
        },
        get_category_list: function(code, all) {
            var type = code.substring(0, 1);
            var xcode = code.substring(1, 4);
            var mcode = code.substring(4, 7);
            var scode = code.substring(7, 10);
            var all = all ? all : '';

            var _1st = $('.pr-search-cate1 > .cover > ul', '.frm-category-sort');
            var _2st = $('.pr-search-cate2 > .cover > ul', '.frm-category-sort');
            var _3st = $('.pr-search-cate3 > .cover > ul', '.frm-category-sort');
            var _opt = [];

            if (code == 'no' || scode != '' || !_2st || (mcode != '' && !_3st)) {
                return false;
            }

            if (xcode == '') {
                _2st.empty();
                _3st.empty();
                $('.pr-search-cate2 > .pr-cate-sel > span', '.frm-category-sort').html('중분류');
                $('.pr-search-cate3 > .pr-cate-sel > span', '.frm-category-sort').html('소분류');
                return false;
            }

            $.ajax({
                type : 'post',
                url  : power_review_pack.info.location_dir + 'category.html',
                data : { xcode: xcode, mcode: mcode },
                dataType: 'json',
                success : function(response) {
                    if (response.success === true) {
                        if (mcode == '') { 
                            _2st.empty().append('<li><a href="#none" code="' + type + xcode + '" all="Y"><span>중분류 전체</span></a></li>')
                            _3st.empty();
                            if (all == '') {
                                $('.pr-search-cate2 > .pr-cate-sel > span', '.frm-category-sort').html('중분류');
                            }
                            $('.pr-search-cate3 > .pr-cate-sel > span', '.frm-category-sort').html('소분류');
                        }
                        if (mcode != '') { 
                            _3st.empty().append('<li><a href="#none" code="' + type + xcode + mcode + '" all="Y"><span>소분류 전체</span></a></li>')
                            if (all == '') {
                                $('.pr-search-cate3 > .pr-cate-sel > span', '.frm-category-sort').html('소분류');
                            }
                        }
                        $.each(response.category, function(key, val) {
                            var _code = mcode == '' ? type + xcode + val.mcode : type + xcode + mcode + val.scode;
                            _opt.push('<li><a href="#none" code="' + _code + '"><span>' + val.codename + '</span></a></li>');
                        });
                        if (_opt.length > 0) {
                            if (mcode == '') {
                                _2st.append(_opt.join(''));
                            } else {
                                _3st.append(_opt.join(''));
                            }
                        } else {
                            if (mcode == '') { 
                                _2st.empty().append('<li><a href="#none" code="no"><span>중분류 없음</span></a></li>')
                            }
                            if (mcode != '') { _3st.empty().append('<li><a href="#none" code="no"><span>소분류 없음</span></a></li>')}
                        }
                    }
                }
            });
        },
        selectbox_action: function(_ob) {
            power_review_search._select_box = _ob;
            _ob.on('mouseleave', function(e) {
                $(this).unbind('mouseleave');

                $(this).on('mouseenter', function(e) {
                    $(this).unbind('mouseenter');
                    $("html").unbind('mousedown.modostar');
                    power_review_search.selectbox_action($(this));
                });                
                $("html").on('mousedown.modostar', function(e) {
                    $(this).unbind('mousedown.modostar');
                    power_review_search._select_box.unbind('mouseenter');
                    $('.cover', power_review_search._select_box).hide(); 
                }); 
            });                

        },
        search: function() {
             $('form[name=prs_form]').submit();
             return false; 
        }
    }

    $(function() {
        var page = power_review_pack.get_page();
        var config = power_review_pack.info.config;
        switch (page) {
            case 'pop_write' :
                power_review_write.init('insert');
                power_review_main.init();
            break;
            case 'mp_review_write' :
            case 'mypage_write' :
                power_review_write.init('insert');
                power_review_main.init();
            break;
            case 'product' :
                power_review_write.init('insert');
                power_review_list.init();
            break;
            case 'search' :
            case 'photo_search' :
                power_review_search.init();
                power_review_list.init();
            break;
            case 'write' :
                power_review_write.init();
            break;
            case 'update' :
                power_review_write.init('update');
            break;
            case 'view' :
                power_review_list.init();
            break;
        }
    });
})(jQuery);

function set_power_review_page (page, config) {
    if (power_review_pack) {
        power_review_pack.set_page(page, config);
    }
    return false;
}
function power_review_next () {
    power_review_main.change_stand(1);
    return;
}
function power_review_prev () {
    power_review_main.change_stand(-1);
    return;
}
function power_review_change_product (ordernum, basketnum) {
    power_review_main.change_product(ordernum, basketnum);
    return;
}
function power_review_get_mp_write (ordernum, basketnum) {
    power_review_main.get_mp_write(ordernum, basketnum);
    return;
}
function power_review_like (uid) {
    power_review_write.like_product(uid);
    return;
}
function power_review_del_file(action, k) {
    power_review_write.del_file(action, k);
}
function power_review_submit () {
    power_review_write.write();
    return;
}
function power_review_more (num1) {
    power_review_list.click_more(num1);
    return;
}
function power_review_more_close (num1) {
    power_review_list.click_more_close(num1);
    return;
}
function power_review_page (page) {
    power_review_list.change_page(page);
    return;
}
function power_review_term (term) {
    power_review_list.change_term(term);
    return;
}
function power_review_sort (sort) {
    power_review_list.change_sort(sort);
    return;
}
function power_review_view_show (num1, num2, fidx, area) {
    power_review_view.show(num1, num2, fidx, area);
    return;
}
function power_review_good (num1, old, page_type) {
    power_review_list.good_review(num1, old, page_type);
    return;
}
function power_review_bad (num1, old, page_type) {
    power_review_list.bad_review(num1, old, page_type);
    return;
}
function power_review_view_comment (num1) {
    power_review_list.view_comment(num1, '');
    return;
}
function power_review_comment_write (num1) {
    power_review_list.write_comment(num1);
    return;
}
function power_review_comment_del (num1, uid) {
    power_review_list.del_comment(num1, uid);
    return;
}
function power_review_comment_mod (num1, uid) {
    power_review_list.mod_comment(num1, uid);
    return;
}
function power_review_update_comment() {
    power_review_list.mod_comment_save();
}
function power_review_del (num1, mode) {
    power_review_list.del_review(num1, mode);
    return;
}
function power_review_modify(num1, mode) {
    power_review_list.update_review(num1, mode);
    return;
}
function power_review_update () {
    power_review_list.update();
    return;
}
function power_review_search_list () {
    power_review_search.search();
    return;
}
function power_review_mypage(ordernum, basketnum, uid) {
    power_review_main.mypage(ordernum, basketnum, uid);
    return;
}
function power_review_today() {
    setCookie('pop_power_review_write', 'HIDE', 1);
    $('#POEWR_REVIEW_WRITE').hide();
}
function power_review_view_close() {
    power_review_view.close();
    //$('#viewPowerReview').popup('hide');
}
function power_review_login(reurl) {
    alert('로그인 후에 작성해 주세요.');
    document.location.href='/m/login.html?return_url='+reurl;
    return;
}
function power_review_file_error() {
    alert('등록가능한 첨부파일 수가 초과되었습니다.');
    return;
}
function power_review_view_change (num1, num2, fidx, area) {
    power_review_view.change(num1, num2, fidx, area);
    return;
}
function power_review_photo_prev () {
    power_review_list.change_photo_list(-1);
    return;
}
function power_review_photo_next () {
    power_review_list.change_photo_list(1);
    return;
}
function power_review_best_prev () {
    power_review_list.change_best_list(-1);
    return;
}
function power_review_best_next () {
    power_review_list.change_best_list(1);
    return;
}
function power_review_view_change_d2 (num1, num2, fidx, area) {
    parent.power_review_view_iframe(num1, num2, fidx, area);
    return;
}
function power_review_main_close() {
    power_review_main.close();
}
function power_review_chkpass() {
    power_review_list.review_chkpass();
    return;
}
function power_review_agree_show() {
    $('.privercy-contract', '#writePowerReview').toggle();
}
function power_review_list_photo(nodata) {
    power_review_list.get_list_type('division', 'Y', nodata);
}
function power_review_list_normal(nodata) {
    power_review_list.get_list_type('division', 'N', nodata);
}
function power_review_list_toggle() {
    var type = $('.pr-photo-toggle > a', '#powerReview').hasClass('now') ? 'A' : 'Y';
    power_review_list.get_list_type('toggle', type);
}
