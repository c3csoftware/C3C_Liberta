trigger EVT_CadastrarAcessoAoCallboxTrigger on CadastrarAcessoAoCallbox__e (after insert) 
{
    TriggerFactory.createTriggerDispatcher(CadastrarAcessoAoCallbox__e.sObjectType, 'CadAcessoCallboxTriggerDispatcher');
}