@isTest
public with sharing class TarefaChamadaViewModelTest 
{
    @isTest 
    static void testeNewInstancePassandoMap()
    {
        new TarefaChamadaViewModel().newInstance(new Map<String, Object>{
            'numeroCelular' => 'teste',
            'idTarefa' => 'teste',
            'dataLigacao' => DateTime.now()
        });
    }  
}