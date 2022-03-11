@isTest
public class BotRecordRetrieverTest 
{
    private static Map<String, ClassTested> mapaDaClasseDeTeste = new Map<String,ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('BuscarInformacoesContaService', Test.createStub(IBuscarInformacoesContaService.class, new BuscarInformacoesContaServiceStub()));
    }

    @isTest
    static void testRetornarHorarioValido()
    {
        setupInjector();
        BotRecordRetriever.BotInput botInput = new BotRecordRetriever.BotInput();
        botInput.codigoXPEmString = '00000';

        List<Object> botOutput = BotRecordRetriever.retornarHorarioValido(new List<BotRecordRetriever.BotInput>{
            botInput,
            botInput
        });

        System.assert(mapaDaClasseDeTeste.containsKey('BuscarInformacoesContaService'), 'A classe deve chamar a classe BuscarInformacoesContaService');
        System.assert(mapaDaClasseDeTeste.get('BuscarInformacoesContaService').containsMethod('obterContasPorCodigosXP'), 'A classe BuscarInformacoesContaService deve ter um método chamado obterContasPorCodigosXP');

        
    }

    private class BuscarInformacoesContaServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'BuscarInformacoesContaService';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapaDaClasseDeTeste;
        }

        public override Object methodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            
            switch on stubbedMethodName
            {
                when 'obterContasPorCodigosXP'
                {
                    returnValue = new List<IContaDomain>();
                }
            }
            
            return returnValue;
        }
    }
}