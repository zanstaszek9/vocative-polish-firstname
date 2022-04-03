/**
 * VocativePolishFirstName
 *
 * Component for remake first name to Polish vocative
 *
 * @author  Mariusz Mielnik <mariusz@ecbox.pl>
 * @author  Stanislaw Zan <zanstaszek9@gmail.com>
 * @license  MIT
 *
 */

public without sharing class VocativeRule {

    public Set<String> nameEndings;
    public VocativePolishFirstName.GENDER gender;
    public Integer replaceFromRight;
    public String vocativeSuffix;

    /**
     * @description
     * @param nameEnding The last letters from tha name that allows to assume Vocative form
     * @param gender A gender to assume
     * @param replaceFromRight Amount of letters to chop from right
     * @param vocativeSuffix Suffix to add to the end of string
     **/
    public VocativeRule(String nameEnding, VocativePolishFirstName.GENDER gender, Integer replaceFromRight, String vocativeSuffix) {
        this(new Set<String>{nameEnding}, gender, replaceFromRight, vocativeSuffix);
    }

    /**
     * @description
     * @param nameEndings A group of the last letters from tha name that allows to assume Vocative form for all endings
     * @param gender A gender to assume
     * @param replaceFromRight Amount of letters to chop from right
     * @param vocativeSuffix Suffix to add to the end of string
     **/
    public VocativeRule(Set<String> nameEndings, VocativePolishFirstName.GENDER gender, Integer replaceFromRight, String vocativeSuffix) {
        this.nameEndings = nameEndings;
        this.gender = gender;
        this.replaceFromRight = replaceFromRight;
        this.vocativeSuffix = vocativeSuffix;
    }

    public Boolean isEndingMatching(final String firstname) {
        return VPFN_StringUtils.endsWithAnySpecifiedIgnoreCase(firstname, this.nameEndings);
    }

    /**
     * @description Return the actual Vocative form
     * @param firstname
     *
     * @return Actual Vocative form
     **/
    public String getVocativeName(final String firstname) {
        return (VPFN_StringUtils.chopString(firstname, this.replaceFromRight)) + vocativeSuffix;
    }



    /**
     * @description List of Vocative Rules with lazy-loading
     **/
    public static List<VocativeRule> vocativeRules {
        public get {
            if (vocativeRules == null) {
                vocativeRules = new List<VocativeRule>();
                populateVocativeRules();
            }
            return vocativeRules;
        }
        private set;
    }

    /**
     * @description Defined rules that should cover all standard Polish vocatives
     **/
    public static void populateVocativeRules() {
        vocativeRules.add(new VocativeRule(new Set<String>{'ni', 'li', 'zi'}, MAN, 0, ''));
        vocativeRules.add(new VocativeRule('eł', MAN, 2, 'le'));
        vocativeRules.add(new VocativeRule('ił', MAN, 1, 'le'));
        vocativeRules.add(new VocativeRule('et', MAN, 1, 'cie'));
        vocativeRules.add(new VocativeRule('tr', MAN, 0, 'ze'));
        vocativeRules.add(new VocativeRule('ał', MAN, 1, 'le'));
        vocativeRules.add(new VocativeRule(new Set<String>{'it', 'rt'}, MAN, 1, 'cie'));
        vocativeRules.add(new VocativeRule('ciek', MAN, 4, 'ćku'));
        vocativeRules.add(new VocativeRule('siek', MAN, 4, 'śku'));
        vocativeRules.add(new VocativeRule('niec', MAN, 4, 'ńcu'));
        vocativeRules.add(new VocativeRule('per', MAN, 2, 'rze'));
        vocativeRules.add(new VocativeRule(new Set<String>{'ek', 'ko'}, MAN, 2, 'ku'));
        vocativeRules.add(new VocativeRule('st', MAN, 2, 'ście'));
        vocativeRules.add(new VocativeRule('sł', MAN, 2, 'śle'));
        vocativeRules.add(new VocativeRule(new Set<String>{'cja', 'ria', 'lia', 'dia', 'wia', 'fia', 'iela', 'bela', 'zula', 'saba'}, WOMAN, 1, 'o'));
        vocativeRules.add(new VocativeRule(new Set<String>{'iola', 'rola'}, WOMAN, 1, 'u'));
        vocativeRules.add(new VocativeRule(new Set<String>{'aja', 'sia'}, WOMAN, 1, 'u'));
        vocativeRules.add(new VocativeRule(new Set<String>{'ja', 'ia', 'la'}, WOMAN, 1, 'o'));
        vocativeRules.add(new VocativeRule('ba', MAN, 1, 'o'));
        vocativeRules.add(new VocativeRule(new Set<String>{'oe', 'ue'}, MAN, 0, ''));
        vocativeRules.add(new VocativeRule('oń', MAN, 1, 'niu'));
        vocativeRules.add(new VocativeRule(new Set<String>{'n', 'f', 'm', 'w', 'p', 's', 'b'}, MAN, 0, 'ie'));
        vocativeRules.add(new VocativeRule('bel', MAN, 3, 'ble'));
        vocativeRules.add(new VocativeRule('ez', WOMAN, 0, ''));
        vocativeRules.add(new VocativeRule(new Set<String>{'g', 'h', 'j', 'k', 'l', 'z'}, MAN, 0, 'u'));
        vocativeRules.add(new VocativeRule('der', MAN, 2, 'rze'));
        vocativeRules.add(new VocativeRule('ster', MAN, 2, 'rze'));
        vocativeRules.add(new VocativeRule('r', MAN, 0, 'ze'));
        vocativeRules.add(new VocativeRule('d', MAN, 0, 'zie'));
        vocativeRules.add(new VocativeRule('a', WOMAN, 1, 'o'));
        vocativeRules.add(new VocativeRule('e', WOMAN, 0, ''));
        vocativeRules.add(new VocativeRule('y', MAN, 0, ''));
        vocativeRules.add(new VocativeRule('o', MAN, 0, ''));
        vocativeRules.add(new VocativeRule('t', MAN, 1, 'cie'));
        vocativeRules.add(new VocativeRule('', UNDEFINABLE, 0, ''));
    }

    /* Defining enums for readability to make callouts shorter **/
    private static VocativePolishFirstName.GENDER MAN =  VocativePolishFirstName.GENDER.MAN;
    private static VocativePolishFirstName.GENDER WOMAN =  VocativePolishFirstName.GENDER.WOMAN;
    private static VocativePolishFirstName.GENDER UNDEFINABLE =  VocativePolishFirstName.GENDER.UNDEFINABLE;
}
