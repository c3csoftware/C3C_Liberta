public interface ITaskDomain
{
    TaskMapper criaTaskMapper(String assunto, String proprietario, String relativo, String tipoTarefa);
    TaskMapper construirTaskMapper(SObject task);
    List<TaskMapper> construirListTaskMapper(List<SObject> listTask);
    TaskMapper obterMapper(); //Responsável por retornar a mapper
    SObject obterRegistro(); //Responsável por retornar o registro SObject
}