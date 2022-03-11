@isTest
public with sharing class LeadTriggerBeforeUpdateHandlerTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('LeadTriggerBeforeUpdateService', Test.createStub(ILeadTriggerBeforeUpdateService.class, new LeadTriggerBeforeUpdateServiceStub()));

        C3C_DIContainer_Injector.createInstance('TratativaDeCampoLeadService', Test.createStub(ITratativaDeCampoLeadService.class, new TratativaDeCampoLeadServiceStub()));

        // C3C_DIContainer_Injector.createInstance('LeadDomain', LeadDomain.class, 'LeadTriggerBeforeUpdateHandlerTest.LeadDomainStub');

        // C3C_DIContainer_Injector.createInstance('TriggerParameters', TriggerParameters.class, 'LeadTriggerBeforeUpdateHandlerTest.TriggerParametersStub');
    }

    @isTest
    static void testeMainEntry()
    {
        setupInjector();

        new LeadTriggerBeforeUpdateHandler().mainEntry(new TriggerParameters(null,new List<SObject>{
            Schema.getGlobalDescribe().get('Lead').newSObject(), Schema.getGlobalDescribe().get('Lead').newSObject()
        },null,null,false,false,false,false,false,false,false)
        );
    }

    public class LeadTriggerBeforeUpdateServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadTriggerBeforeUpdateService';
        }

        public override Map<String,ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    public class TratativaDeCampoLeadServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TratativaDeCampoLeadService';
        }

        public override Map<String,ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    public class LeadDomainStub  extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadDomain';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        // public override Object methodCall(
        //     Object stubbedObject, 
        //     String stubbedMethodName,
        //     Type returnType, 
        //     List<System.Type> listOfParamTypes, 
        //     List<String> listOfParamNames,
        //     List<Object> listOfArgs
        // )
        // {
        //     Object returnValue;
            
            
        //     switch on stubbedMethodName
        //     {
        //         when 'newInstance'
        //         {
        //             returnValue = new List<ILeadDomain>{
        //                (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain')
        //             };
        //         }

        //     }
            
        //     return returnValue;
        // }
    }

    public class TriggerParametersStub  extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TriggerParameters';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
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
                when 'newList'
                {
                    returnValue = new List<SObject>{
                        Schema.getGlobalDescribe().get('Lead').newSObject(),
                        Schema.getGlobalDescribe().get('Lead').newSObject()
                    };
                }

            }
            
            return returnValue;
        }
    }
}