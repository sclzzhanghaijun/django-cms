var bodyH = $("body").height();
var headerH = $("#top").height();
var containerH = $(".contert-container").height();
var footerH = $(".footer").height();
if ((headerH + containerH + footerH) < bodyH) {
    $(".footer").css("margin-top", bodyH - (headerH + containerH + footerH) - 25);
}
var $form_modal = $('.cd-user-modal'),
    $form_login = $form_modal.find('#cd-login'),
    $form_signup = $form_modal.find('#cd-signup'),
    $form_modal_tab = $('.cd-switcher'),
    $tab_login = $form_modal_tab.children('li').eq(0).children('a'),
    $tab_signup = $form_modal_tab.children('li').eq(1).children('a'),
    $main_nav = $('.main_nav');

//弹出窗口
$main_nav.on('click', function (event) {

    if ($(event.target).is($main_nav)) {
        // on mobile open the submenu
        $(this).children('ul').toggleClass('is-visible');
    } else {
        // on mobile close submenu
        $main_nav.children('ul').removeClass('is-visible');
        //show modal layer
        $form_modal.addClass('is-visible');
        //show the selected form
        if ($(event.target).is('.cd-signup')) {
            signup_selected()
        }
        else if ($(event.target).is('.cd-signin')) {
            login_selected()
        }
    }
});

//菜单跳转
function jump(self) {
    var _this = $(self);
    var data_value = _this.attr('data-value');
    if (data_value === 'true' && globalVariable.login_status === false) {
        $main_nav.children('ul').removeClass('is-visible');
        $form_modal.addClass('is-visible');
        login_selected();
        return true;
    }
    location.href = _this.attr('data-href')
}

//登录检测和菜单加载
$.ajax({
    url: globalVariable.login_status_and_load_menu,
    async: false,
    success: function (res) {
        if (res.status) {
            var default_avatar = res.avatar ? res.avatar : globalVariable.default_avatar;
            $("#already-login").show().children().eq(0).attr('src', default_avatar).next().text(res.username);
            globalVariable.login_status = true;
        } else {
            $(".main_nav").show();
            globalVariable.login_status = false;
        }
        var html = '';
        $.each(res['menu_list'], function (key, val) {
            var item = '';
            var menu_item_length = val['menu_item'].length;
            if (menu_item_length > 0) {
                item += '<ul>';
                $.each(val['menu_item'], function (k, v) {
                    item += '<li><a  target="_blank" href="' + v['link_url'] + '">' + v['menu_name'] + '</a></li>'
                });
                item += '</ul>';
                html += '<li class="nav-news js-show-menu"><a data-href="' + val['link_url'] + '">' + val['menu_name'] + '<span class="caret"></span></a>' + item + '</li>'
            } else {
                html += '<li class="nav-news"><a onclick="jump(this)" data-value="' + val['need_login'] + '" data-href="' + val['link_url'] + '">' + val['menu_name'] + '</a></li>'
            }
        });
        $("#jsddm").append(html);

        $('#jsddm > li').bind('mouseover', jsddm_open);
        $('#jsddm > li').bind('mouseout', jsddm_timer);
        document.onclick = jsddm_close;
    }
});
//热文加载
if($("#hot_article").length>0){
    $.getJSON(globalVariable.hotarticle_url,function (res) {
        var html='';
        $.each(res,function(key,value){
            var href=globalVariable.article_url+'?article_id='+value['article_id'];
            var src=value['value.thumb']?value['value.thumb']:globalVariable.default_hotarticle_thumb[Math.floor((Math.random()*globalVariable.default_hotarticle_thumb.length-1)+1)];
            html+='<li>' +
                    '<div class="hot-article-img">' +
                        '<a href="'+href+'" target="_blank" title="'+value['article_title']+'"><img src="'+src+'"></a></div>' +
                        '<a href="'+href+'" class="transition" target="_blank">'+value['article_title']+'</a>' +
                '</li>'
        });
        $("#hot_article").html(html);
    })
}
//去注册
$(".js-open-register").on('click', function () {
    $main_nav.children('ul').removeClass('is-visible');
    $form_modal.addClass('is-visible');
    signup_selected()
});
//去登录
$(".js-user-login,.js-login-sl").on('click', function () {
    $main_nav.children('ul').removeClass('is-visible');
    $form_modal.addClass('is-visible');
    login_selected()
});
//关闭弹出窗口
$('.cd-user-modal').on('click', function (event) {
    if ($(event.target).is($form_modal) || $(event.target).is('.cd-close-form')) {
        $form_modal.removeClass('is-visible');
    }
});
//使用Esc键关闭弹出窗口
$(document).keyup(function (event) {
    if (event.which == '27') {
        $form_modal.removeClass('is-visible');
    }
});

//切换表单
$form_modal_tab.on('click', function (event) {
    event.preventDefault();
    ($(event.target).is($tab_login)) ? login_selected() : signup_selected();
});

function login_selected() {
    $form_login.addClass('is-selected');
    $form_signup.removeClass('is-selected');
    $tab_login.addClass('selected');
    $tab_signup.removeClass('selected');
}

function signup_selected() {
    $form_login.removeClass('is-selected');
    $form_signup.addClass('is-selected');
    $tab_login.removeClass('selected');
    $tab_signup.addClass('selected');
}

$(".login-input").on('focus', function () {
    $(".string-message").html("&nbsp");
});

//登录
$(".js-btn-login").on('click', function () {
    var username = $('#login_username').val();
    var pwd = $('#login_password').val();
    if (username === "") {
        $(".message-login").text('请输入的邮箱地址或用户名');
        return false;
    }
    if (pwd === '') {
        $(".message-login").text('请输入登录密码');
        return false;
    }
    $.post(globalVariable.submit_login_url, {username: username, password: pwd}, function (result) {
        if (result.code === 1) {
            location.reload()
        } else {
            $(".message-login").text(result.msg);
        }
    });
});

//发送验证码
var getRegisterCode = false;
$(".get-register-code").on('click', function () {
    var email = $('input[name="email"]').val();
    if (email === "") {
        $(".message-register").text('请输入邮箱地址');
        return false;
    }
    if (getRegisterCode !== false) {
        $(".message-register").text('邮件已发送，请前往邮箱查看验证码');
        return false;
    }
    $.post(globalVariable.send_email_url, {mail: email}, function (result) {
        if (result.code === 0) {
            $(".message-register").text(result.msg);
            return false;
        } else {
            getRegisterCode = true;
            $(".get-register-code").text('获取成功');
            return true;
        }
    });
});
$(".register-btn").on('click', function () {
    var email = $('input[name="email"]').val();
    var password = $('input[name="register_password"]').val();
    var code = $("input[name='register_code']").val();
    if (email === "") {
        $(".message-register").text('请输入邮箱地址');
        return false;
    }
    if (password === '') {
        $(".message-register").text('请输入登录密码');
        return false;
    }
    if (code === '') {
        $(".message-register").text('请输入六位邮箱验证码');
        return false;
    }
    $.post(globalVariable.register_url, {
        mail: email,
        password: password,
        code: code,
    }, function (result) {
        if (result.code === 0) {
            $(".message-register").text(result.msg);
            return true;
        } else {
            $main_nav.children('ul').removeClass('is-visible');
            $form_modal.addClass('is-visible');
            login_selected()
        }
    });
});
//退出登录
$(".login-out").on('click', function () {
    $.post(globalVariable.logout_url, function (res) {
        if (res.code === 1) {
            location.href = res.url
        }
    })
});

