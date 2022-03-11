public without sharing class BotCriarPesquisa
{
    public class BotInput
    {
    	@InvocableVariable(required=false)
    	public String codigoCliente;
        @InvocableVariable(required=true)
    	public String notaPesquisa;
        @InvocableVariable(required=true)
    	public String entidadePesquisa;
        @InvocableVariable(required=false)
    	public String nomeCliente;
    }

    @InvocableMethod(label='Criar Pesquisa')
    public static void criarPesquisa(List<BotInput> botInputs)
    {
        List<IRespostaPesquisaDomain> listaRespostaPesquisaDomain = new List<IRespostaPesquisaDomain>();
    
        for (BotInput botInput : botInputs)
        {
            listaRespostaPesquisaDomain.add((IRespostaPesquisaDomain) C3C_DIContainer_Injector.newInstance('RespostaPesquisaDomain', new Map<String, Object>{
                'codigoCliente' => botInput.codigoCliente, 
                'nota' => botInput.notaPesquisa,
                'entidadePesquisa' => botInput.entidadePesquisa,
                'nomeCliente' => botInput.nomeCliente != '' ? botInput.nomeCliente : ''
            }));
        }
     	
        respostaPesquisaServiceInstance.inserirRespostaPesquisaPorBot(listaRespostaPesquisaDomain);
    }
    
    // Service
    public static IRespostaPesquisaService respostaPesquisaServiceInstance 
    {
        get
        {
            if(respostaPesquisaServiceInstance == null)
                respostaPesquisaServiceInstance = (IRespostaPesquisaService) C3C_DIContainer_Injector.getInstance('RespostaPesquisaService');
            
            return respostaPesquisaServiceInstance;
        }
        set;
    }
}