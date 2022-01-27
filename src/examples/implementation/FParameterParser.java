public class FParameterParser extends FBaseParserVisitor<Parameter> {

    private final FTypeParser typeParser;
    private final FTermParser termParser;

    FParameterParser(FTermParser termParser) {
        this.termParser = termParser;
        this.typeParser = new FTypeParser(termParser);
    }

    public Result<Parameter> visitParameter(FrogParser.ParameterContext ctx) {
        return ParameterBuilder.builder()
                .term(parseTerm(ctx))
                .type(parseType(ctx))
                .build();
    }

    private Result<Term> parseTerm(FrogParser.ParameterContext ctx) {
        return termParser.toBlankNodeTerm(termParser.getVariableLabel(ctx.Variable())).map(t -> (Term) t);
    }

    private Result<Type> parseType(FrogParser.ParameterContext ctx) {
        return ctx.type() == null
                ? null
                : this.typeParser.visitType(ctx.type());
    }
}