public without sharing class BuscarInformacoesContaService implements IBuscarInformacoesContaService
{
	public List<IContaDomain> obterContasPorCodigosXP(List<String> codigosXP)
    {
        return (List<IContaDomain>) C3C_DIContainer_Injector.newInstance('ContaDomain',(List<SObject>) this.contaSelectorInstance.obterContasPorCodigosXP(codigosXP));
    }

    public IContaDomain obterContaPorIdChaveExterna(String idChaveExterna)
    {
        return (IContaDomain) C3C_DIContainer_Injector.newInstance('ContaDomain', this.contaSelectorInstance.obterContaPorIdChaveExterna(idChaveExterna));
    }
    
    //Selector
    public IContaSelector contaSelectorInstance 
    {
        get
        {
            if(this.contaSelectorInstance == null)
                this.contaSelectorInstance = (IContaSelector) C3C_DIContainer_Injector.getInstance('ContaSelector');
            
            return this.contaSelectorInstance;
        }
        set;
    }
}