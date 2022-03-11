public class BotRecordRetriever 
{
	public class BotOutput 
 	{
    	@InvocableVariable(required=true)
    	public Boolean codigoValidacao;
  	}

  	public class BotInput 
  	{
    	@InvocableVariable(required=true)
    	public String codigoXPEmString; 
  	}

    @InvocableMethod(label='Identificar Código XP')
    public static List<BotOutput> retornarHorarioValido(List<BotInput> botInputs) 
    {
        Map<String, BotOutput> mapaCodigoComVadicacao = new Map<String, BotOutput>();
        List<String> codigosXP = new List<String>();
        for(BotInput itemBotInput:botInputs)
        {
            codigosXP.add(itemBotInput.codigoXPEmString);
        }
        obterMapaCodigoComValidacao(codigosXP, mapaCodigoComVadicacao, buscarInformacoesContaServiceInstance.obterContasPorCodigosXP(codigosXP));
 
    	return mapaCodigoComVadicacao.values();
    }
    
    public static void obterMapaCodigoComValidacao(List<String> codigosXP, Map<String, BotOutput> mapaCodigoComVadicacao, List<IContaDomain> listaContasExistentes)
    {
        for(String itemCodigoXP:codigosXP)
        {
            BotRecordRetriever.BotOutput objBotOutput = new BotRecordRetriever.BotOutput();
            objBotOutput.codigoValidacao = false;
            mapaCodigoComVadicacao.put(itemCodigoXP, objBotOutput);
            for(IContaDomain itemConta:listaContasExistentes)
            {
                ContaMapper contaMapper = itemConta.obterMapper();
                if(itemCodigoXP == contaMapper.codigo)
                {
                    objBotOutput.codigoValidacao = true;
                    mapaCodigoComVadicacao.put(itemCodigoXP, objBotOutput);
                }
            }
        }
    }
    
    // Service
    public static IBuscarInformacoesContaService buscarInformacoesContaServiceInstance 
    {
        get
        {
            if(buscarInformacoesContaServiceInstance == null)
                buscarInformacoesContaServiceInstance = (IBuscarInformacoesContaService) C3C_DIContainer_Injector.getInstance('BuscarInformacoesContaService');
            
            return buscarInformacoesContaServiceInstance;
        }
        set;
    }
}