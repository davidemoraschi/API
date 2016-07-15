/* Formatted on 13/01/2014 17:36:04 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
SET DEFINE OFF

--BEGIN
--	p_flip_from_rss (p_rss_url => 'http://news.google.es/news/feeds?cf=all&ned=es&hl=es&topic=m&output=rss'
--									,p_user => 'EuroStrategy'
--									,p_pass => '3SamsungGalaxySII'
--									,p_target_magazine => 'flipboard/mag-M4sfaY1mTfWWyp4EpnhHNQ%3Am%3A120774391');
--                                    --magazineTarget=flipboard/mag-M4sfaY1mTfWWyp4EpnhHNQ%3Am%3A120774391
--END;
--/
--
--EXEC dbms_output.put_line( f_flip_login (p_user => 'EuroStrategy', p_pass => '3SamsungGalaxySII'));
--/

BEGIN
	p_flip_upload (p_url => 'http://www.prensa-latina.cu/index.php?option=com_content&task=view&idioma=1&id=2258391&Itemid=1'
								,p_csrf => f_flip_login (p_user => 'EuroStrategy', p_pass => '3SamsungGalaxySII')
--                                ,p_csrf => f_flip_login (p_user => 'davide_moraschi', p_pass => 'Lepanto1571')
--								,p_target_magazine => 'flipboard/mag-M4sfaY1mTfWWyp4EpnhHNQ%3Am%3A120774391');
                                ,p_target_magazine => 'flipboard/mag-M4sfaY1mTfWWyp4EpnhHNQ%3Am%3A120774391-123011160');
                                
END;