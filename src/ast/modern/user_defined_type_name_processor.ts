import { ASTReader, ASTReaderConfiguration } from "../ast_reader";
import { UserDefinedTypeName } from "../implementation/type/user_defined_type_name";
import { ModernTypeNameProcessor } from "./type_name_processor";

export class ModernUserDefinedTypeNameProcessor extends ModernTypeNameProcessor<UserDefinedTypeName> {
    process(
        reader: ASTReader,
        config: ASTReaderConfiguration,
        raw: any
    ): ConstructorParameters<typeof UserDefinedTypeName> {
        const [id, src, type, typeString] = super.process(reader, config, raw);

        const name: string = raw.name;
        const referencedDeclaration: number = raw.referencedDeclaration;

        return [id, src, type, typeString, name, referencedDeclaration, raw];
    }
}