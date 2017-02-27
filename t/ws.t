use Test::More;
use Test::Mojo;

use FindBin;
require "$FindBin::Bin/../server.pl";

my $t = Test::Mojo->new();

# HTML/XML
$t->get_ok('/')->status_is(302);
$t->get_ok('/index.html')->status_is(200)->text_is('html head title' => 'Cellular Automaton');

# WebSocket
$t->websocket_ok('/ws')
  ->send_ok({json => { cmd => 'start'}})
  ->message_ok
  ->json_message_is({ generation => 1, universe => [ 1 ]})
  ->message_ok
  ->json_message_is({ generation => 2, universe => [ 1, 1, 1 ]})
  ->message_ok
  ->json_message_is({ generation => 3, universe => [ 1, 1, 0, 0, 1 ]})
  ->finish_ok;

done_testing();
