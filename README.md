motp
====

MobileOTP for Indeed-ID. This app generates one time passwords for Indeed-ID to Windows login.
It uses http://motp.sourceforge.net algorithm.
To generate one time password you need the current epoch-time in a 10 second granularity, 16-symbol Secret-Init code and 4-digit PIN code.
Algorithm looks like otp = MD5 (epoch + secret_init + pin).substring(0, 6).

Server and phone time must be syncronized. To compensate time differences, server accepts passwords from 3 minutes in the past and 3 minutes in the future.
It works with Indeed-ID ESSO: http://indeed-id.com

====

Данное приложение генерирует одноразовые пароли для системы Indeed-ID, что позволяет войти в систему  Windows.
Оно использует алгоритм, описанный на http://motp.sourceforge.net
Чтобы сгенерировать одноразовый пароль, вам потребуется число, равное количеству секунд с 1 января 1970 года до текущего момента, поделённое на 10 без остатка, 16-символьный секретный код и PIN, состоящий из 4 цифр.
Псевдокод выглядит так: otp = MD5 (epoch + secret_init + pin).substring(0, 6).

Время на сервере и на телефоне должно совпадать. Чтобы не возникало проблем, сервер должен принимать пароли в промежутке +- 3 минуты от настоящего момента.
Приложение работает с системой Indeed-ID ESSO: http://indeed-id.ru
