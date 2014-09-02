<?php
/**
 *
 * @author Oakensoul (http://www.oakensoul.com/)
 * @link https://github.com/web-masons/application-blueprint for the canonical source repository
 * @copyright Copyright (c) 2013 Robert Gunnar Johnson Jr. and Project Contributors
 * http://opensource.org/licenses/Apache-2.0 Apache-2.0-Clause
 * @package Cornerstone
 */
namespace ApplicationBlueprint\Console\Listener;

use Exception;
use Zend\EventManager;
use Zend\ServiceManager;
use Zend\Console\ColorInterface;
use Cornerstone\EventManager\Service;
use Cornerstone\EventManager\Console;
use Zend\Config\Config;
use Zend\Console\Response;

/**
 * This Listener is placed as an example of an implementation that you should provide
 * if your derived module requires any Configuration listeners.
 *
 * This is an EXAMPLE so that the command itself can run at build time, etc. The purpose
 * is for a developer to add required configs that must be set to the "check" so that it
 * will fail if the value is not properly set.
 *
 * @author oakensoul
 */
class CheckConfiguration extends EventManager\AbstractListenerAggregate implements ServiceManager\ServiceLocatorAwareInterface
{

    protected $mServiceLocator;

    /**
     * {@inheritDoc}
     */
    public function attach (EventManager\EventManagerInterface $pEventManager)
    {
        $options = array ();
        $options[] = $this;
        $options[] = 'EventHandler';

        $this->listeners[] = $pEventManager->attach(Service::EVENT_APPLICATION_CHECK_CONFIGURATION, $options, 1);
        $this->listeners[] = $pEventManager->attach(Service::EVENT_APPLICATION_INITIALIZE, $options, 500);
    }

    public function EventHandler (Console\Event $pEvent)
    {
        try
        {
            $console = $this->getServiceLocator()->get('console');

            $config = $this->getServiceLocator()->get('Config');

            if (true == $pEvent->getVerboseFlag())
            {
                $console->write(' --------------- ', ColorInterface::LIGHT_GREEN);
                $console->writeLine('-----------------------------------------------------------', ColorInterface::YELLOW);

                $console->write("      [Listener] ", ColorInterface::LIGHT_GREEN);
                $console->writeLine(__CLASS__, ColorInterface::YELLOW);

                $console->write(' --------------- ', ColorInterface::LIGHT_GREEN);
                $console->writeLine('-----------------------------------------------------------', ColorInterface::YELLOW);

                /**
                 * Place some verbose logging here for whatever you're checking above. Whether it passed/failed etc.
                 */
            }

            /**
             * Place code here to check the configuration value's existence, or to make sure it's set, etc.
             * It might be worth placing a NULL config variable in the module.config.php file so that
             * you can check to see what its value is. If you need something where NULL is an acceptable
             * value you may want to set a dummy unacceptable value, etc.
             */

            if ('example' == $config['Installation']['Vhost']['Server']['Domain'])
            {
                $error_message = 'Application config error, Installation->Vhost->Server->Domain is still set to default value.';

                if (true == $pEvent->getVerboseFlag())
                {
                    $console->write("       [Failure] ", ColorInterface::RED);
                    $console->writeLine($error_message . PHP_EOL, ColorInterface::RED);
                }

                throw new Exception($error_message);
            }

            if ('app-skeleton.' == $config['Installation']['Vhost']['Server']['Region'])
            {
                $error_message = 'Application config error, Installation->Vhost->Server->Region is still set to default value.';

                if (true == $pEvent->getVerboseFlag())
                {
                    $console->write("       [Failure] ", ColorInterface::RED);
                    $console->writeLine($error_message . PHP_EOL, ColorInterface::RED);
                }

                throw new Exception($error_message);
            }

            return NULL;
        }
        catch (Exception $e)
        {
            $response = new Response();
            $response->setErrorLevel(1);
            $response->setContent('Exception Encountered: ' . $e->getMessage());

            return $response;
        }
    }

    /**
     * Set service locator
     *
     * @param ServiceManager\ServiceLocatorInterface $serviceLocator
     */
    public function setServiceLocator (ServiceManager\ServiceLocatorInterface $serviceLocator)
    {
        $this->mServiceLocator = $serviceLocator;
    }

    /**
     * Get service locator
     *
     * @return ServiceManager\ServiceLocatorInterface
     */
    public function getServiceLocator ()
    {
        return $this->mServiceLocator;
    }
}
