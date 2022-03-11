@isTest
public class ADP_ObInforLoginCallBoxUsuarioAtualTest {
    
    public static void setupContext() {
        C3C_DIContainer_Injector.createInstance('AcessoCallBoxService', Test.createStub(AcessoCallBoxService.class, new AcessoCallBoxServiceStub()));
        C3C_APP_ContractInterfaceApplication contract = (C3C_APP_ContractInterfaceApplication) C3C_DIContainer_Injector.newInstance(
            'C3C_APP_ContractInterfaceApplication', 
            JSON.serialize(new Map<String, Object>{
                'requestBody' => new Map<string,Object>{
                    'service' => 'service',
                    'serviceMethod' => 'serviceMethod'
                    // 'bodyMap' => '{"oppIdSet": ["ID1", "ID1"], "oppIdDescriptionMap": {"ID1": "desc_1", "ID2": "desc_2"}}'
                    // 'bodyMap' => new Map<String, String>{
                    //     'task' => '[{"recordId": "'+taskId+'"}]'
                    // }
                },
                'enabledPath' => false,
                'returnType' => 'returnType'
        }));
        C3C_APP_ApplicationContext.initialize(contract);
    }
    
    @isTest
    public static void testeCallMethod()
    {
        // Task t = new Task(Id=fflib_IDGenerator.generate(Task.sObjectType));
        
        // setupContext(t.Id);
        setupContext();
        ADP_ObterInforLoginCallBoxUsuarioAtual adp = new ADP_ObterInforLoginCallBoxUsuarioAtual();
        adp.callMethod();
    }
    
    public class AcessoCallBoxServiceStub implements System.StubProvider
    {
        public Object handleMethodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> 
            listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            // switch on stubbedMethodName 
            // {
            //     when  'obterInformacoesDoLoginCallBoxDoUsuarioAtual'
            //     {
            //         returnValue = (SegurancaLoginCallboxMapper) C3C_DIContainer_Injector.newInstance('AcessoCallBoxService');
            //     }
        
            // }

            return returnValue;
        }
    }
}