-module(service_ginger_rest_edges).
-author("Driebit <tech@driebit.nl>").

-svc_title("Create resource edges.").

-svc_needauth(true).

-export([
    process_post/2
]).

-include_lib("zotonic.hrl").

process_post(_ReqData, Context) ->
    case z_context:get_q("predicate", Context) of
        undefined -> 
            {error, missing_arg, "predicate"};
        PredicateURI ->
            Id = z_context:get_q("id", Context),
            case m_rsc:rid(Id, Context) of
                undefined -> 
                    {error, not_exists, Id};
                SubjectId ->
                    Predicate = m_rsc:uri_lookup(PredicateURI, Context),
                    case m_predicate:is_predicate(Predicate, Context) of
                        true ->
                            case z_context:get_q("object", Context) of
                                undefined ->
                                    {error, missing_arg, "object"};
                                Object ->
                                    case m_rsc:rid(Object, Context) of
                                        undefined 
                                            -> {error, not_exists, Object};
                                        ObjectId ->
                                            z_convert:to_json(m_edge:insert(SubjectId, Predicate, ObjectId, Context))
                                    end
                            end;
                        false ->
                            {error, not_exists, PredicateURI}
                    end
            end
    end.
