public with sharing class OportunidadeTriggerBeforeInsertHandler extends TriggerHandlerBase
{
    public class OportunidadeTriggerBeforeInsertHandlerException extends Exception{}

    //Construtores
    public OportunidadeTriggerBeforeInsertHandler() {}

    //Métodos
    public override void mainEntry(TriggerParameters tp) 
    {
        List<IOportunidadeDomain> listaOportunidadeDomain = (List<IOportunidadeDomain>) C3C_DIContainer_Injector.newInstance('OportunidadeDomain',(List<SObject>) tp.newList);
        
        this.oportunidadeTriggerBeforeInsertServiceInstance.modificarProprietarioOportunidadeSemDono(listaOportunidadeDomain);
    }
    
    public override void inProgressEntry(TriggerParameters tp) {}
    
    public override void updateObjects() {}

    //Atributos de serviço
    private IOportunidadeTriggerBeforeInsertService oportunidadeTriggerBeforeInsertServiceInstance
    {
        get
        {
            if(this.oportunidadeTriggerBeforeInsertServiceInstance == null)
                this.oportunidadeTriggerBeforeInsertServiceInstance = (IOportunidadeTriggerBeforeInsertService) C3C_DIContainer_Injector.getInstance('OportunidadeTriggerBeforeInsertService');

            return this.oportunidadeTriggerBeforeInsertServiceInstance;
        }
        set;
    }
}