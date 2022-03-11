@isTest
public with sharing class ChecklistViewModelTest 
{
    @isTest 
    static void testePerguntaViewModelClass()
    {
        new ChecklistViewModel.PerguntaViewModel(
            (PerguntaMapper) C3C_DIContainer_Injector.newInstance('PerguntaMapper'),
            new List<RespostaMapper>{(RespostaMapper) C3C_DIContainer_Injector.newInstance('RespostaMapper')},
            new List<InstanciaRespostaMapper>{(InstanciaRespostaMapper) C3C_DIContainer_Injector.newInstance('InstanciaRespostaMapper')}        
        );
    }

    @isTest 
    static void testeListaDePerguntas()
    {
        Object listPergunta =  new ChecklistViewModel().listaDePerguntas;

        System.assert(listPergunta instanceOf List<CheckListViewModel.PerguntaViewModel>, 'O atributo da classe CheckListViewModel.PerguntaViewModel deve ser chamado');

    }
}