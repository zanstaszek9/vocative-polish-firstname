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

public without sharing class VPFN_StringUtils {
    /**
     * @description Check if last letters of toBeChopped matches all Suffixes
     *
     * @param toBeChecked String to check suffixes
     * @param suffixes
     *
     * @return True - String End With Any of Suffixes
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
     *
     * @param toBeChopped String to be chopped
     * @param amountOfLettersToRemoveFromRight
     *
     * @return Chopped String
     **/
    public static String chopString(final String toBeChopped, final Integer amountOfLettersToRemoveFromRight) {
        return (toBeChopped.substring(0, toBeChopped.length() - amountOfLettersToRemoveFromRight));
    }
}