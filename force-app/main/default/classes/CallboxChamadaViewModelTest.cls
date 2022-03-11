@isTest
public with sharing class CallboxChamadaViewModelTest 
{
    @isTest 
    static void testeCallboxChamadaViewModel()
    {
        CallboxChamadaViewModel call = new CallboxChamadaViewModel();
        call.dataInicioChamada = 'teste';
        call.numeroDestino = 'teste';
        call.ramalUtilizado = 'teste';
        call.duracaoSegudos = 1;
        call.idTarefaChamada = 'teste';
        call.dataTerminoChamada = 'teste';
        call.linkAcessarGravacaoChamada = 'teste';
        call.registroRelacionado = 'teste';
    }
}