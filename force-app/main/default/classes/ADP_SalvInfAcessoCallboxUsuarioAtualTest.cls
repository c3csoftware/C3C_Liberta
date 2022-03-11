@isTest
public class ADP_SalvInfAcessoCallboxUsuarioAtualTest 
{
    public static void setupContext() {
        C3C_DIContainer_Injector.createInstance('AcessoCallboxService', Test.createStub(AcessoCallboxService.class, new AcessoCallboxServiceStub()));
        C3C_APP_ContractInterfaceApplication contract = (C3C_APP_ContractInterfaceApplication) C3C_DIContainer_Injector.newInstance(
            'C3C_APP_ContractInterfaceApplication', 
            JSON.serialize(new Map<String, Object>{
                'requestBody' => new Map<string,Object>{
                    'service' => 'service',
                    'serviceMethod' => 'serviceMethod',
                    // 'bodyMap' => '{"oppIdSet": ["ID1", "ID1"], "oppIdDescriptionMap": {"ID1": "desc_1", "ID2": "desc_2"}}'
                    'bodyMap' => new Map<String, String>{
                        // 'task' => '[{"recordId": "'+taskId+'"}]',
                        'ramalUsuario' => 'ramalUsuario',
                        'senhaCallbox' => 'senhaCallbox'
                    },
                    'listaDePerguntasDaTarefa' => 'listaDePerguntasDaTarefa'
                },
                'enabledPath' => false,
                'returnType' => 'returnType'
        }));
        C3C_APP_ApplicationContext.initialize(contract);
    }
    
	@isTest
    static void testecCallMethod()
    {
        setupContext();
        new ADP_SalvarInforAcessoCallboxUsuarioAtual().callMethod();
    }
    
    public class AcessoCallboxServiceStub implements System.StubProvider
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
            
            return returnValue;
        }
    }
}