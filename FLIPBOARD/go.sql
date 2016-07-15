/* Formatted on 1/11/2014 11:09:28 PM (QP5 v5.163.1008.3004) */
SET DEFINE OFF

BEGIN
   p_flip_from_rss (p_rss_url           => 'http://news.google.es/news/feeds?cf=all&ned=es&hl=es&topic=m&output=rss',
                    p_user              => 'davide_moraschi',
                    p_pass              => 'Lepanto1571',
                    p_target_magazine   => 'flipboard/mag-M4sfaY1mTfWWyp4EpnhHNQ%3Am%3A120774391');
END;