$(function() {

    //accredit1
    $('.encapsulation').on('click', function() {
        alert('封装信封成功！')
    })

    $('.open').on('click', function() {
        alert("拆封信息成功！")
    })

    $('.encryption').on('click', function() {
        alert("对称加密成功！")
    })

    $('.decode').on('click', function() {
        alert("对称解密成功！")
    })

    //accredit2

    $('.create').on('click', function() {
        alert("生成许可证！")
    })

    //accredit3
    $('.authorization').on('click', function() {
        alert('许可证授权成功！');
    })

    $('.searching').on('click', function() {
        alert('许可证检索完毕！');
    })

    //credential3
    $('.create2').on('click', function() {
        alert('生成证书成功！');
    })

    //sysetem1
    $('.affirm').on('click', function() {
        alert('设置成功！');
    })

    //system2
    $('.install').on('click', function() {
        alert('许可证安装成功！');
    })
    $('.uninstall').on('click', function() {
        alert('许可证卸载成功！');
    })
    $('.activate').on('click', function() {
        alert('许可证激活成功！');
    })
    $('.pause').on('click', function() {
        alert('已暂停许可证！');
    })

    //system4
    $('.ensure').on('click', function() {
        alert('网络设置成功！');
    })

    //user1
     $('.submit').on('click', function() {
        alert('角色提交成功！');
    })
})