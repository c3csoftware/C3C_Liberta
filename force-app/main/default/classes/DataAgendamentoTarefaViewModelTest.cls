@isTest
public with sharing class DataAgendamentoTarefaViewModelTest 
{
    @isTest 
    static void testeNewInstancePassandoMap()
    {
        new DataAgendamentoTarefaViewModel().newInstance(new Map<String, Object> {
            'dataAgendamento' => Date.today()
        });
    }

    @isTest 
    static void testeNewInstancePassandoDate()
    {
        new DataAgendamentoTarefaViewModel().newInstance(Date.today());
    }

    @isTest 
    static void testeAdicionarAgendamentoTarefa()
    {
        new DataAgendamentoTarefaViewModel().adicionarAgendamentoTarefa(new AgendamentoTarefaMapper(), new TaskMapper());
    }

    @isTest 
    static void testeCoverage()
    {
        DataAgendamentoTarefaViewModel.testCoverage();
    }
}