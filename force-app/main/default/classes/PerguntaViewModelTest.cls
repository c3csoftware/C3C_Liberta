@isTest
public with sharing class PerguntaViewModelTest 
{
    @isTest
    static void testeNewInstancePassandoMap()
    {
        // GIVEN
        PerguntaMapper pergMpp = (PerguntaMapper) C3C_DIContainer_Injector.newInstance('PerguntaMapper');
        pergMpp.tipo = 'Dissertativa';
        
        RespostaMapper respMpp = (RespostaMapper) C3C_DIContainer_Injector.newInstance('RespostaMapper');
        respMpp.habilitarColetaInformacoes = true;

        // WHEN
        new PerguntaViewModel().newInstance(new Map<String, Object>{
            'pergunta' => pergMpp,
            'listaDeRespostasDisponiveis' => new List<RespostaMapper>{
                respMpp
            },
            'listaDeRespostasRespondidas' => new List<InstanciaRespostaMapper>{
                (InstanciaRespostaMapper) C3C_DIContainer_Injector.newInstance('InstanciaRespostaMapper')
            }
        });
    }

    @isTest
    static void testeNewInstancePassandoMapComPerguntaUnicaEscolha()
    {
        // GIVEN
        PerguntaMapper pergMpp = (PerguntaMapper) C3C_DIContainer_Injector.newInstance('PerguntaMapper');
        pergMpp.tipo = 'Única escolha';

        RespostaMapper respMpp = (RespostaMapper) C3C_DIContainer_Injector.newInstance('RespostaMapper');
        respMpp.habilitarColetaInformacoes = true;
        
        // WHEN
        new PerguntaViewModel().newInstance(new Map<String, Object>{
            'pergunta' => pergMpp,
            'listaDeRespostasDisponiveis' => new List<RespostaMapper>{
                respMpp
            },
            'listaDeRespostasRespondidas' => new List<InstanciaRespostaMapper>{
                (InstanciaRespostaMapper) C3C_DIContainer_Injector.newInstance('InstanciaRespostaMapper')
            }
        });
    }

    @isTest
    static void testeNewInstancePassandoMapComPerguntaMultiplaEscolha()
    {
        // GIVEN
        PerguntaMapper pergMpp = (PerguntaMapper) C3C_DIContainer_Injector.newInstance('PerguntaMapper');
        pergMpp.tipo = 'Múltipla escolha';
        
        RespostaMapper respMpp = (RespostaMapper) C3C_DIContainer_Injector.newInstance('RespostaMapper');
        respMpp.habilitarColetaInformacoes = true;
        
        // WHEN
        new PerguntaViewModel().newInstance(new Map<String, Object>{
            'pergunta' => pergMpp,
            'listaDeRespostasDisponiveis' => new List<RespostaMapper>{
                respMpp
            },
            'listaDeRespostasRespondidas' => new List<InstanciaRespostaMapper>{
                (InstanciaRespostaMapper) C3C_DIContainer_Injector.newInstance('InstanciaRespostaMapper')
            }
        });
    }
}