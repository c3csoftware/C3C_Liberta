public interface IContaDomain 
{
    ContaMapper construirContaMapper(SObject conta);
    List<ContaMapper> construirListContaMapper(List<SObject> listConta);
    ContaMapper obterMapper(); //Responsável por retornar a mapper
    SObject obterRegistro(); //Responsável por retornar o registro SObject
}