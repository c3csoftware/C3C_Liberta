@isTest
public with sharing class ValidarCpfTest 
{
    @isTest
    static void testCoverage()
    {
        ValidarCpf.testCoverage();
    } 

    @isTest 
    static void testeRetornarCpfValido()
    {
        ValidarCpf.retornarCpfValido(new List<ValidarCpf.BotInput>());
    }
}

// @istest 
// private class UserChatBotTest {
//     @istest
//     private static void testChatBot() {
//         // create test data for messaging end user
        
//         MessagingEndUser meu = new MessagingEndUser ();	
//     	meu.Name= 'Message User';
//         meu.MessagingChannelId = 'enter your message channel ID here';
// 		meu.MessagingPlatformKey='whatsapp:+9172XXXXXXXX';
//     	meu.MessageType= 'WhatsApp';
//     	database.insert(meu);
        
//         UserChatBot.BotInput BI = new UserChatBot.BotInput();
//         BI.endUserId = UserInfo.getUserId();
//         List<UserChatBot.BotInput> biList = new List<UserChatBot.BotInput>();
//         biList.add(BI);
        
//         Test.startTest();
//         List<UserChatBot.BotResponse> BR = UserChatBot.getPhoneNo(biList);
//         Test.stopTest();
//         system.assertEquals(1, BR.size(),'we expect bot response');
//     }

// }