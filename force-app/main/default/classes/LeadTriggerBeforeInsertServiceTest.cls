@isTest
public with sharing class LeadTriggerBeforeInsertServiceTest 
{
    public static Map<String,ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('GroupService', Test.createStub(IGroupService.class, new GroupServiceStub()));
    }

    @isTest
    static void testeAtualizarLeads()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new LeadTriggerBeforeInsertService().modificarProprietarioLeadSemDono(new List<ILeadDomain>{
            (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', Schema.getGlobalDescribe().get('Lead').newSObject())
        });

        // THEN
    }

    public class GroupServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'GroupService';
        }

        public override Map<String,ClassTested> getMapClassTested()
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
                when 'obterGroupPorNome'
                {
                    GroupMapper leadSemDono = (GroupMapper) C3C_DIContainer_Injector.newInstance('GroupMapper');

                    leadSemDono.recordId = [SELECT id FROM group WHERE Name = 'Lead sem Dono'].Id;

                    returnValue = leadSemDono;
                }
            }
            
            return returnValue;
        }
    }
}