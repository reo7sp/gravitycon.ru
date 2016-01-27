<!DOCTYPE HTML>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			setTimeout(function () {
				window.location.href = "news.html";
			}, 2500);
		</script>
	</head>
	<body>

<?php
if (isset($_POST['surname']) ||
	isset($_POST['firstname']) ||
	isset($_POST['lastname']) ||
	isset($_POST['age']) ||
	isset($_POST['about']) ||
	isset($_POST['fraction'])
	) {
	// generate data
	$data =
		'Фамилия: '  . $_POST['surname']   . PHP_EOL .
		'Имя: '      . $_POST['firstname'] . PHP_EOL .
		'Отчество: ' . $_POST['lastname']  . PHP_EOL .
		'Возраст: '  . $_POST['age']       . PHP_EOL .
		'О нем: '    . $_POST['about']     . PHP_EOL .
		'Фракция: '  . $_POST['fraction'];

	// write to file
	if ($handle = fopen('regs.txt', 'a')) {
		fwrite($handle, PHP_EOL . '-----' . PHP_EOL . $data);
		fclose($handle);
	}

	// send mail
	mail('fractions@gravitycon.ru', 'Новая регистрация на gravitycon.ru', $data);

	// send feedback
	echo '<h1>Успешно отправлено!</h1>';
} else {
	echo '<h1>Неправильные данные</h1>';
}
?>

	</body>
</html>
