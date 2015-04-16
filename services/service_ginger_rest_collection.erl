-module(service_ginger_rest_collection).
-author("Driebit <tech@driebit.nl>").

-svc_title("Post a resource to a collection.").

-svc_needauth(true).

-export([
    process_post/2
]).

-include_lib("zotonic.hrl").

process_post(_ReqData, Context) ->
%%     Category = z_context:get_q("category", Context),
    
    Props = z_context:get_q_all_noz(Context),
    ?DEBUG(Props),
    case m_rsc_update:insert(Props, [{escape_texts, false}], Context) of
        {ok, Id} ->
            z_convert:to_json([{rsc_id, Id}]);
        {error, R} ->
            {error, R, <<>>}
    end.
    
    
    

    
%%     ?DEBUG(z_context:get_q("file", Context)),
%%     Upload = #upload{} = z_context:get_q("file", Context),
%%     
%%     Persons = z_context:get_q("persons", Context),
%%     ?DEBUG(Persons),
%%     
%% %%     Props = lists:flatten(
%% %%             lists:map(
%% %%               fun(Prop) ->
%% %%                       Value = z_context:get_q(atom_to_list(Prop), Context, <<>>),
%% %%                       case z_utils:is_empty(Value) of
%% %%                           false -> [{Prop, Value}];
%% %%                           true -> []
%% %%                       end
%% %%               end,
%% %%               [title, summary, body, chapeau, subtitle, website, page_path]
%% %%              )
%% %%            ), 
%%     Props = [],
%%     case m_media:insert_file(Upload, Props, Context) of
%%         {ok, Id} ->
%%             %% Store edge links
%%             lists:foreach(
%%                 fun(PersonId) ->
%%                     m_edge:insert(Id, depicts, PersonId, Context)
%%                 end,
%%                 Persons
%%             ),
%%             z_convert:to_json([{rsc_id, Id}]);
%%         {error, R} ->
%%             {error, R, <<>>}
%%     end.
%%     
