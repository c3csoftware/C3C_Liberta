@isTest
public with sharing class AgendaDoUsuarioViewModelTest 
{
    @isTest
    static void testeNewInstancePassandoMap()
    {
        new AgendaDoUsuarioViewModel().newInstance(
            new Map<String,Object>{
                'idUsuario' => 'idUsuario',
                'eventos' => new List<EventMapper>{(EventMapper) C3C_DIContainer_Injector.newInstance('EventMapper')}
            }
        );
    }

    @isTest 
    static void testeNewInstancePassandoNull()
    {
        new AgendaDoUsuarioViewModel().newInstance(null);
    }
}