public without sharing class ChecklistViewModel 
{
    //Atributos
    @AuraEnabled 
    public List<PerguntaViewModel> listaDePerguntas 
    {
        get
        {
            if(this.listaDePerguntas == null)
                this.listaDePerguntas = new List<PerguntaViewModel>();

            return this.listaDePerguntas;
        }
        set;
    }

    //Classe responsável por ser o modelo da pergunta para o front
    public class PerguntaViewModel
    {
        public PerguntaMapper pergunta {get;set;}
        public List<RespostaMapper> listaDeRespostasDisponiveis {get;set;}
        public List<InstanciaRespostaMapper> listaDeRespostasSelecionadas {get;set;} 

        public PerguntaViewModel(
            PerguntaMapper pergunta,
            List<RespostaMapper> listaDeRespostasDisponiveis,
            List<InstanciaRespostaMapper> listaDeRespostasSelecionadas
        )
        {
            this.pergunta = pergunta;
            this.listaDeRespostasDisponiveis = listaDeRespostasDisponiveis;
            this.listaDeRespostasSelecionadas = listaDeRespostasSelecionadas;
        }
    }

    //Construtores
    public ChecklistViewModel()
    {}
}