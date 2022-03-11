public without sharing class InstancRespTriggerAfterInsertHandler extends TriggerHandlerBase 
{
    public class InstancRespTriggerAfterInsertHandlerException extends Exception{}

    // Construtores
    public InstancRespTriggerAfterInsertHandler() {}

    // Métodos
    public override void mainEntry(TriggerParameters tp)
    {
        List<IInstanciaRespostaDomain> listaInstanciaRespostaDomain = (List<IInstanciaRespostaDomain>) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain',(List<SObject>) tp.newList);

        this.instanciaRespTriggerAfterInsertServiceInstance.mudarStatusTarefaParaCompletado(listaInstanciaRespostaDomain);

        this.instanciaRespTriggerAfterInsertServiceInstance.mudarStatusLeadParaPrimeiroContato(listaInstanciaRespostaDomain);

        this.instanciaIntegracaoResPerguntaParaCampoSObject.integrarRespostasPerguntaComCamposSobject(listaInstanciaRespostaDomain);

        this.instanciaRespTriggerAfterInsertServiceInstance.mudarStatusCasoParaEncerrado(listaInstanciaRespostaDomain);
    }

    public override void inProgressEntry(TriggerParameters tp) {}

    public override void updateObjects() {}

    // Atributos de serviço

    private IInstanciaRespTriggerAfterInsertService instanciaRespTriggerAfterInsertServiceInstance
    {
        get
        {
            if(this.instanciaRespTriggerAfterInsertServiceInstance == null)
                this.instanciaRespTriggerAfterInsertServiceInstance = (IInstanciaRespTriggerAfterInsertService) C3C_DIContainer_Injector.getInstance('InstanciaRespTriggerAfterInsertService');

            return this.instanciaRespTriggerAfterInsertServiceInstance;
        }
        set;
    }

    private IIntegracaoResPerguntaParaCampoSObject instanciaIntegracaoResPerguntaParaCampoSObject
    {
        get
        {
            if(this.instanciaIntegracaoResPerguntaParaCampoSObject == null)
                this.instanciaIntegracaoResPerguntaParaCampoSObject = (IIntegracaoResPerguntaParaCampoSObject) C3C_DIContainer_Injector.getInstance('IntegracaoResPerguntaParaCampoSObject');

            return this.instanciaIntegracaoResPerguntaParaCampoSObject;
        }
        set;
    }
}