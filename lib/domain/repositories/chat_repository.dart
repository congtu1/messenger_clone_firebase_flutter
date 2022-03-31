
abstract class ChatRepository {
  Future<void> fetchConversationInformation(String id);
  Future<void> fetchConversationMessage(String id);
  Future<void> newConversation(Map<String,String> conversation);
  Future<void> updateConversationRecentMessage(String idConversation, recentMessage);
  Future<void> newMessage(String idConversation,message);

}