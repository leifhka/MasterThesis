
public class CheckUndefinedParameters implements Check {

    private static final String queryFile = "checkVariableExists.rq";

    @Override
    public String getValidationFile() {
        return queryFile;
    }

    public MessageHandler errorMessage(ResultSet resultSet) {
        var msgs = new MessageHandler();
        var list = ResultSetFormatter.toList(resultSet);
        list.forEach(querySolution -> {
            String functionName = querySolution.get("functionName").toString();
            var parameterVariable = Frog.getVarNameFromUniqueId(
                    querySolution.get("parameterVariable").asResource());
            msgs.add(Message.error("Variable " + parameterVariable
                    + " which is used in function " + functionName
                    + " is never declared"));
        });
        return msgs;
    }
}
