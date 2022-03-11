public interface ILeadAssessorService 
{
    //Responsável por criar uma tarefa de "Conversão de Lead" caso o lead for criado por um usuário Assessor Liberta
    void criarTarefaConversaoLeadQuandoCriadoPerfilAssessorLiberta(List<ILeadDomain> listaLead);
}