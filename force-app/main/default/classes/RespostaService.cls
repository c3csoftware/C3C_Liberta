public without sharing class RespostaService implements IRespostaService
{
    public List<IRespostaDomain> obterRespostasPorListaIdPergunta(Set<String> idsPergunta)
    {
        return (List<IRespostaDomain>) C3C_DIContainer_Injector.newInstance('RespostaDomain', this.respostaSelectorInstance.obterRespostasPorListaIdPergunta(idsPergunta));
    }

    //Selector
    public IRespostaSelector respostaSelectorInstance 
    {
        get
        {
            if(this.respostaSelectorInstance == null)
                this.respostaSelectorInstance = (IRespostaSelector) C3C_DIContainer_Injector.getInstance('RespostaSelector');
            
            return this.respostaSelectorInstance;
        }
        set;
    }
}