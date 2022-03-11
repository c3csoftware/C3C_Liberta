@isTest
public class ADP_SalvarRespostasDaTarefaTest 
{
    
    public static void setupContext(String taskId) 
    {
        C3C_DIContainer_Injector.createInstance('ChecklistService', Test.createStub(ChecklistService.class, new ChecklistServiceStub()));

        C3C_APP_ContractInterfaceApplication contract = (C3C_APP_ContractInterfaceApplication) C3C_DIContainer_Injector.newInstance(
            'C3C_APP_ContractInterfaceApplication', 
            JSON.serialize(new Map<String, Object>{
                'requestBody' => new Map<string,Object>{
                    'service' => 'service',
                    'serviceMethod' => 'serviceMethod',
                    // 'bodyMap' => '{"oppIdSet": ["ID1", "ID1"], "oppIdDescriptionMap": {"ID1": "desc_1", "ID2": "desc_2"}}'
                    'bodyMap' => new Map<String, String>{
                        'task' => '[{"recordId": "'+taskId+'"}]',
                        'listaDePerguntasDaTarefa' => '[]'
                    },
                    'listaDePerguntasDaTarefa' => 'listaDePerguntasDaTarefa'
                },
                'enabledPath' => false,
                'returnType' => 'returnType'
        }));
        C3C_APP_ApplicationContext.initialize(contract);
    }
    
    @isTest
    public static void callMethodTest()
    {
        Task t = new Task(Id=fflib_IDGenerator.generate(Task.sObjectType));
        
        setupContext(t.Id);
        ADP_SalvarRespostasDaTarefa adp = new ADP_SalvarRespostasDaTarefa();
        adp.callMethod();
    }
    
    public class ChecklistServiceStub implements System.StubProvider
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