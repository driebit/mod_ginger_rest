-module(mod_ginger_rest_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("zotonic.hrl").

post_test() ->
    C = z_context:new(testsandboxdb),
    Sudo = z_acl:sudo(C),
    Response = service_ginger_rest_collection:process_post([], Sudo),
    ?DEBUG(Response).

