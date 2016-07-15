/* Formatted on 15/01/2014 16:36:02 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
UPDATE UTL_LOG_SWEEP_UPLOAD_FOLDER SET FLIPPED = NULL;

DECLARE
	const_website_url CONSTANT VARCHAR2 (2048) := 'http://pandas10.azurewebsites.net/';
	const_flipboard_user CONSTANT VARCHAR2 (200) := 'EuroStrategy';
	const_flipboard_pass CONSTANT VARCHAR2 (200) := '3SamsungGalaxySII';
	const_flipboard_magazine CONSTANT VARCHAR2 (2048) := 'flipboard/mag-M4sfaY1mTfWWyp4EpnhHNQ%3Am%3A120774391-123011160';
BEGIN
	FOR c1 IN (SELECT filename
							 FROM UTL_LOG_SWEEP_UPLOAD_FOLDER
							WHERE FLIPPED IS NULL AND F_GET_FILEEXT (filename) IN ('.htm', '.html', '.HTM', '.HTML')) LOOP
		UPDATE UTL_LOG_SWEEP_UPLOAD_FOLDER
			 SET FLIPPED = f_flip_from_url (p_url => const_website_url || c1.filename
																		 ,p_user => const_flipboard_user
																		 ,p_pass => const_flipboard_pass
																		 ,p_target_magazine => const_flipboard_magazine)
		 WHERE filename = c1.filename;
	END LOOP;
END;