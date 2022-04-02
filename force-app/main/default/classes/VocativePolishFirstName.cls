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


public class VocativePolishFirstName {

    /**
     * @description Structure to hold name, sex and vocative
     */
    public class VocativeSex { //TODO: Change name
        public final String denominatorName;
        public String sex;
        public String vocative = '';
        private String commonConjunction = 'i';

        /**
         * @description
         * @param denominatorName name in denominator (pl. mianownik) form
         * @param sex sex indication in form of letters, 'U' for 'Unable to define', 'W' for Woman, 'M' for Man
         * @param vocative name in vocative (pl. wołacz) form
         **/
        public VocativeSex(String denominatorName, String sex, String vocative) {
            this.denominatorName = denominatorName;
            this.sex = sex;
            this.vocative = vocative;
        }

        public Boolean hasDefinedVocativeAndSex() {
            return String.isNotBlank(this.vocative) && String.isNotBlank(this.sex);
        }


        public void attachConjunction(String aString) {
            if (isConjunctionBetweenTwoNames(aString)) {
                this.sex = 'G';
            }
            this.vocative += aString;
        }

        public void attachToVocativeSex(String denominatorName, VocativeRule vocativeRule) {
            this.sex = (String.isBlank(this.sex)) ? this.sex = vocativeRule.gender : this.sex;
            this.vocative += vocativeRule.getVocativeName(denominatorName);
        }

        private Boolean isConjunctionBetweenTwoNames(String aString){
            //TODO make static
            return aString == commonConjunction;
        }
    }


    /**
     * @description Polish definitions array for default group
     * <p/>
     * U = Unable to define
     * M = Male
     * W = Woman
     */
    private final Map<String, Map<String, String>> titles = new Map<String, Map<String, String>>{
            'default' => new Map<String, String>{
                    'G' => 'Państwo',
                    'U' => 'Panie/Pani',
                    'M' => 'Panie',
                    'W' => 'Pani'
            }
    };

    private VocativeSex vocative;

    /**
     * @description List of exceptions
     */
    public final Map<String, VocativeSex> exceptions = new Map<String, VocativeSex>{
            'Ola' => new VocativeSex('Ola', 'W', 'Olu'),
            'Saba' => new VocativeSex('Saba', 'W', 'Sabo'),
            'Noemi' => new VocativeSex('Noemi', 'W', 'Noemi'),
            'Sonia' => new VocativeSex('Sonia', 'W', 'Soniu'),
            'Luba' => new VocativeSex('Luba', 'W', 'Lubo'),
            'Jeremi' => new VocativeSex('Jeremi', 'M', 'Jeremi'),
            'Kirył' => new VocativeSex('Kirył', 'M', 'Kiryle'),
            'Miriam' => new VocativeSex('Miriam', 'W', 'Miriam'),
            'Margot' => new VocativeSex('Margot', 'W', 'Margot'),
            'Ingrid' => new VocativeSex('Ingrid', 'W', 'Ingrid'),
            'Lew' => new VocativeSex('Lew', 'M', 'Lwie'),
            'Narcyz' => new VocativeSex('Narcyz', 'M', 'Narcyzie'),
            'Kosma' => new VocativeSex('Kosma', 'M', 'Kosmo'),
            'Bonawentura' => new VocativeSex('Bonawentura', 'M', 'Bonawenturo'),
            'Carmen' => new VocativeSex('Carmen', 'W', 'Carmen'),
            'Doris' => new VocativeSex('Doris', 'W', 'Doris'),
            'Dolores' => new VocativeSex('Dolores', 'W', 'Dolores'),
            'Abigail' => new VocativeSex('Abigail', 'W', 'Abigail'),
            'Nikolett' => new VocativeSex('Nikolett', 'W', 'Nikoletto'),
            'Ania' => new VocativeSex('Ania', 'W', 'Aniu')
    };


    /**
     * @description
     * @param first_name
     * @param titles
     * @param exceptions
     **/
    public VocativePolishFirstName(String first_name, Map<String, String> titles, Map<String, VocativeSex> exceptions) {
        if (!titles.isEmpty()) {
            this.setTitles(titles);
        }

        if (!exceptions.isEmpty()) {
            this.exceptions.putAll(exceptions);
        }

        this.remakeToVocative(first_name);
    }

    /**
     * @description
     * @param first_name
     **/
    public VocativePolishFirstName(String first_name) {
        this(first_name, new Map<String, String>(), new Map<String, VocativePolishFirstName.VocativeSex>());
    }

    /**
     * @description Return default titles definition
     *
     * @return array
     */
    public Map<String, String> getTitles() {
        return this.titles.get('default');
    }

    /**
     * @description Returns titles definition by group name
     *
     * @param aGroup
     *
     * @return Map<String, String>
     */
    public Map<String, String> getTitlesByGroup(String aGroup) {
        return this.titles.get(aGroup);
    }

    /**
     * @description Setup own titles like Mr&#47; Mrs, Panie&#47;Pani
     * <p/>
     * for english ex. ['U' => '', 'M' => 'Mrs.', 'W' => 'Mr.'];
     * <p/>
     * for polish ex. ['U' => '', 'M' => 'Szanowny Panie', 'W' => 'Szanowna Pani'];
     * <p/>
     * For multiple titles definitions use group name
     * <p/>
     * for polish ex. group: 'default' => ['U' => 'Panie &#47;  Pani', 'M' => 'Panie', 'W' => 'Pani'];
     * <p/>
     * for polish ex. group: 'polite' => ['U' => '', 'M' => 'Szanowny Panie', 'W' => 'Szanowna Pani'];
     *
     * @param titles
     **/
    public void setTitles(Map<String, String> titles) {
        setTitles(titles, 'default');
    }

    /**
     * @description Setup own titles like Mr&#47; Mrs, Panie&#47;Pani
     * <p/>
     * for english ex. ['U' => '', 'M' => 'Mrs.', 'W' => 'Mr.'];
     * <p/>
     * for polish ex. ['U' => '', 'M' => 'Szanowny Panie', 'W' => 'Szanowna Pani'];
     * <p/>
     * For multiple titles definitions use group name
     * <p/>
     * for polish ex. group: 'default' => ['U' => 'Panie &#47;  Pani', 'M' => 'Panie', 'W' => 'Pani'];
     * <p/>
     * for polish ex. group: 'polite' => ['U' => '', 'M' => 'Szanowny Panie', 'W' => 'Szanowna Pani'];
     *
     * @param titles
     * @param aGroup
     */
    public void setTitles(Map<String, String> titles, String aGroup) {
        this.titles.put(aGroup, titles);
    }


    /**
     * @description Returns array with vocative firs name and gender.
     *
     * @return VocativeSex
     */
    public VocativeSex getVocativeSex() {   //TODO: Change name
        return this.vocative;
    }

    /**
     * @description Returns vocative first name
     *
     * @return string
     */
    public String getVocativeFirstName() { //TODO: Change name
        return this.vocative.vocative;
    }
    /**
     * @description Returns title for a given Group that has been previously defined
     *
     * @param aGroup
     *
     * @return String
     */
    public String getDetectedTitle(String aGroup) {
        return this.titles.get(aGroup).get(this.vocative.sex);
    }

    /**
     * @description Returns title for default settings
     *
     * @return string
     */
    public String getDetectedTitle() {
        return this.getDetectedTitle('default');
    }

    /**
     * @description Returns gender M - Male, W - Woman, U - Unknown
     *
     * @return string
     */
    public String getDetectedGender() {
        return this.vocative.sex;
    }


    /**
     * @description Returns true if first name belongs to man
     *
     * @return bool
     */
    public Boolean isMan() {
        if (this.vocative.sex == 'M') {
            return true;
        }

        return false;
    }

    /**
     * @description Returns true if first name belongs to woman
     *
     * @return bool
     */
    public Boolean isWoman() {
        if (this.vocative.sex == 'W') {
            return true;
        }

        return false;
    }

    /**
     * @description Return vocative first name with title
     *
     * @param delimiter default ' ' (space)
     * @param aGroup group
     *
     * @return string
     */
    public String getVocativeStringWithTitle(String delimiter, String aGroup) {
        return this.getDetectedTitle(aGroup) + delimiter + this.getVocativeFirstName();
    }

    /**
     * @description Return vocative first name with title, with specified delimiter and default Group
     *
     * @param delimiter
     *
     * @return String
     */
    public String getVocativeStringWithTitle(String delimiter) {
        return getVocativeStringWithTitle(delimiter, 'default');
    }

    /**
     * @description Return vocative first name with title, with delimiter of Space and default Group
     *
     * @return String
     */
    public String getVocativeStringWithTitle() {
        return getVocativeStringWithTitle(' ', 'default');
    }

    /**
     * @description Convert name to make every first letter up, split by character type
     *
     * @param name
     *
     * @return string
     */
    public static String nameCaseConvert(String name) {
        String output = '';
        for (String str : name.toLowerCase().splitByCharacterTypeCamelCase()) {
            output += str.capitalize();
        }
        return output;
    }


    /**
     * @description
     * @param first_name
     *
     * @return VocativeSex
     *
     * @throws VocativePolishFirstNameException
     */
    private VocativeSex checkExceptions(String first_name) {
        final VocativeSex nameWithException = this.exceptions.get(first_name);
        if (nameWithException == null) {
            return null;
        }

        if (!nameWithException.hasDefinedVocativeAndSex()) {
            throw new VocativePolishFirstNameException('Invalid format - exception to the rules of firstname must have specified gender and vocative form.');
        }

        switch on nameWithException.sex {
            when 'M', 'W', 'U' {
                return nameWithException;
            }
            when else {
                throw new VocativePolishFirstNameException('Undefined gender');
            }
        }

    }


    /**
     * @description Remake first name to Polish vocative
     *
     * @param firstname firstname
     *
     * @throws VocativePolishFirstNameException
     */
    public void remakeToVocative(String firstname) {
        if (String.isBlank(firstname)) {
            throw new VocativePolishFirstNameException('First name cannot be empty');
        }

        if (this.vocative == null) {
            firstname = nameCaseConvert(firstname).trim();
            VocativeSex creatingVocative = new VocativeSex(firstname, '', '');
            this.vocative = creatingVocative;

            for (String partOfName : firstname.splitByCharacterTypeCamelCase()) {
                final VocativeSex tempVocative = this.checkExceptions(partOfName);
                if (isInExceptionList(tempVocative)) {
                    this.vocative = tempVocative;
                    return;
                }

                if (isSpaceOrDelimiterOrConjunction(partOfName.length())) {
                    creatingVocative.attachConjunction(partOfName.toLowerCase());
                    continue;
                }

                try {
                    for (VocativeRule vocativeRule : vocativeRules) {
                        if (vocativeRule.isEndingMatching(partOfName)) {
                            creatingVocative.attachToVocativeSex(partOfName, vocativeRule);
                            break;
                        }
                    }
                }
                catch (StringException e) {
                    throw new VocativePolishFirstNameException('An error with name ' + partOfName + ':  ' + e, e);
                }
            }


        }
    }

    private Boolean isInExceptionList(VocativeSex tempVocative) {
        return tempVocative != null;
    }

    private Boolean isSpaceOrDelimiterOrConjunction(Integer partOfName) {
        final Integer maxDelimiterLength;
        return partOfName <= maxDelimiterLength;
    }

    /**
     * @description Check if last letters of toBeChopped matches all Suffixes
     *
     * @param toBeChecked String to check suffixes
     * @param suffixes
     *
     * @return
     **/
    public static Boolean endsWithAnySpecifiedIgnoreCase(final String toBeChecked, final Set<String> suffixes) {
        Boolean doesStringEndsWithAnySuffix = false;
        for (String suffix : suffixes) {
            doesStringEndsWithAnySuffix |= toBeChecked.endsWithIgnoreCase(suffix);
        }
        return doesStringEndsWithAnySuffix;
    }

    /**
     * @description Removes letters from the right
     * @param toBeChopped String to be chopped
     * @param amountOfLettersToRemoveFromRight
     *
     * @return
     **/
    public static String chopString(final String toBeChopped, final Integer amountOfLettersToRemoveFromRight) {
        return (toBeChopped.substring(0, toBeChopped.length() - amountOfLettersToRemoveFromRight));
    }

    public class VocativeRule {
        public Set<String> nameEndings;
        public String gender;
        public Integer replaceFromRight;
        public String vocativeSuffix;

        /**
         * @description
         * @param nameEnding The last letters from tha name that allows to assume Vocative form
         * @param gender A gender to assume
         * @param replaceFromRight Amount of letters to chop from right
         * @param vocativeSuffix Suffix to add to the end of string
         **/
        public VocativeRule(String nameEnding, String gender, Integer replaceFromRight, String vocativeSuffix) {
            this(new Set<String>{nameEnding}, gender, replaceFromRight, vocativeSuffix);
        }

        /**
         * @description
         * @param nameEndings A group of the last letters from tha name that allows to assume Vocative form for all endings
         * @param gender A gender to assume
         * @param replaceFromRight Amount of letters to chop from right
         * @param vocativeSuffix Suffix to add to the end of string
         **/
        public VocativeRule(Set<String> nameEndings, String gender, Integer replaceFromRight, String vocativeSuffix) {
            this.nameEndings = nameEndings;
            this.gender = gender;
            this.replaceFromRight = replaceFromRight;
            this.vocativeSuffix = vocativeSuffix;
        }

        public Boolean isEndingMatching(final String firstname) {
            return endsWithAnySpecifiedIgnoreCase(firstname, this.nameEndings);
        }

        /**
         * @description Return the actual Vocative form
         * @param firstname
         *
         * @return Actual Vocative form
         **/
        public String getVocativeName(final String firstname) {
            return (chopString(firstname, this.replaceFromRight)) + vocativeSuffix;
        }

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
        vocativeRules.add(new VocativeRule(new Set<String>{'ni', 'li', 'zi'}, 'M', 0, ''));
        vocativeRules.add(new VocativeRule('eł', 'M', 2, 'le'));
        vocativeRules.add(new VocativeRule('ił', 'M', 1, 'le'));
        vocativeRules.add(new VocativeRule('et', 'M', 1, 'cie'));
        vocativeRules.add(new VocativeRule('tr', 'M', 0, 'ze'));
        vocativeRules.add(new VocativeRule('ał', 'M', 1, 'le'));
        vocativeRules.add(new VocativeRule(new Set<String>{'it', 'rt'}, 'M', 1, 'cie'));
        vocativeRules.add(new VocativeRule('ciek', 'M', 4, 'ćku'));
        vocativeRules.add(new VocativeRule('siek', 'M', 4, 'śku'));
        vocativeRules.add(new VocativeRule('niec', 'M', 4, 'ńcu'));
        vocativeRules.add(new VocativeRule('per', 'M', 2, 'rze'));
        vocativeRules.add(new VocativeRule(new Set<String>{'ek', 'ko'}, 'M', 2, 'ku'));
        vocativeRules.add(new VocativeRule('st', 'M', 2, 'ście'));
        vocativeRules.add(new VocativeRule('sł', 'M', 2, 'śle'));
        vocativeRules.add(new VocativeRule(new Set<String>{'cja', 'ria', 'lia', 'dia', 'wia', 'fia', 'iela', 'bela', 'zula', 'saba'}, 'W', 1, 'o'));
        vocativeRules.add(new VocativeRule(new Set<String>{'iola', 'rola'}, 'W', 1, 'u'));
        vocativeRules.add(new VocativeRule(new Set<String>{'aja', 'sia'}, 'W', 1, 'u'));
        vocativeRules.add(new VocativeRule(new Set<String>{'ja', 'ia', 'la'}, 'W', 1, 'o'));
        vocativeRules.add(new VocativeRule('ba', 'M', 1, 'o'));
        vocativeRules.add(new VocativeRule(new Set<String>{'oe', 'ue'}, 'M', 0, ''));
        vocativeRules.add(new VocativeRule('oń', 'M', 1, 'niu'));
        vocativeRules.add(new VocativeRule(new Set<String>{'n', 'f', 'm', 'w', 'p', 's', 'b'}, 'M', 0, 'ie'));
        vocativeRules.add(new VocativeRule('bel', 'M', 3, 'ble'));
        vocativeRules.add(new VocativeRule('ez', 'W', 0, ''));
        vocativeRules.add(new VocativeRule(new Set<String>{'g', 'h', 'j', 'k', 'l', 'z'}, 'M', 0, 'u'));
        vocativeRules.add(new VocativeRule('der', 'M', 2, 'rze'));
        vocativeRules.add(new VocativeRule('ster', 'M', 2, 'rze'));
        vocativeRules.add(new VocativeRule('r', 'M', 0, 'ze'));
        vocativeRules.add(new VocativeRule('d', 'M', 0, 'zie'));
        vocativeRules.add(new VocativeRule('a', 'W', 1, 'o'));
        vocativeRules.add(new VocativeRule('e', 'W', 0, ''));
        vocativeRules.add(new VocativeRule('y', 'M', 0, ''));
        vocativeRules.add(new VocativeRule('o', 'M', 0, ''));
        vocativeRules.add(new VocativeRule('t', 'M', 1, 'cie'));
        vocativeRules.add(new VocativeRule('', 'U', 0, '')); //TODO Test czy nameEnding pusty jest TRUE
    }
}