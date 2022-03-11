@isTest
public class ADP_ObterAgendaUsuariosFilaDurPerTest {
    
    public static void setupContext(/** String idFila */) {
        C3C_DIContainer_Injector.createInstance('CalendarioDeEventosService', Test.createStub(CalendarioDeEventosService.class, new CalendarioDeEventosServiceStub()));
        C3C_APP_ContractInterfaceApplication contract = (C3C_APP_ContractInterfaceApplication) C3C_DIContainer_Injector.newInstance(
            'C3C_APP_ContractInterfaceApplication', 
            JSON.serialize(new Map<String, Object>{
                'requestBody' => new Map<string,Object>{
                    'service' => 'service',
                    'serviceMethod' => 'serviceMethod',
                    // 'bodyMap' => '{"oppIdSet": ["ID1", "ID1"], "oppIdDescriptionMap": {"ID1": "desc_1", "ID2": "desc_2"}}'
                    'bodyMap' => new Map<String, String>{
                        'idFila' => 'idFila',
                        'dataDeInicio' => '2021-11-10T14:53:55.000+0000',
                        'dataDeTermino' => '2021-11-11T14:53:55.000+0000'
                    }
                },
                'enabledPath' => false,
                'returnType' => 'returnType'
        }));
        C3C_APP_ApplicationContext.initialize(contract);
    }
    
    @isTest
    public static void callMethodTest()
    {
        // Task t = new Task(Id=fflib_IDGenerator.generate(Task.sObjectType));
        
        setupContext(/** t.Id*/);
        ADP_ObterAgendaUsuariosFilaDurPer adp = new ADP_ObterAgendaUsuariosFilaDurPer();
        adp.callMethod();
    }
    
    public class CalendarioDeEventosServiceStub implements System.StubProvider
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