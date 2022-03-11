@isTest
public with sharing class ADP_CriarAtualizarTarefaChamadaTest {
    
    public static void setupContext() {
        C3C_DIContainer_Injector.createInstance('TaskCallService', Test.createStub(TaskCallService.class, new TaskCallServiceStub()));
        C3C_APP_ContractInterfaceApplication contract = (C3C_APP_ContractInterfaceApplication) C3C_DIContainer_Injector.newInstance(
            'C3C_APP_ContractInterfaceApplication', 
            JSON.serialize(new Map<String, Object>{
                'requestBody' => new Map<string,Object>{
                    'service' => 'service',
                    'serviceMethod' => 'serviceMethod',
                    // 'bodyMap' => '{"oppIdSet": ["ID1", "ID1"], "oppIdDescriptionMap": {"ID1": "desc_1", "ID2": "desc_2"}}'
                    'bodyMap' => new Map<String, String>{
                        'callboxChamadaInfo' => '{"1", "test", [], {}, true, false}'
                    },
                    'listaDePerguntasDaTarefa' => 'listaDePerguntasDaTarefa'
                },
                'enabledPath' => false,
                'returnType' => 'returnType'
        }));
        C3C_APP_ApplicationContext.initialize(contract);
    }
    
    // @isTest
    // public static void callMethodTest()
    // {        
    //     setupContext();
    //     ADP_CriarAtualizarTarefaChamada adp = new ADP_CriarAtualizarTarefaChamada();
    //     adp.callMethod();
    // }
    
    public class TaskCallServiceStub implements System.StubProvider
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

    @isTest 
    static void testCoverage()
    {
        ADP_CriarAtualizarTarefaChamada.testCoverage();
    }

}