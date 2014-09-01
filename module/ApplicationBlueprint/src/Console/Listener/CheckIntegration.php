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
 * so that you can check and make sure that your integration points are working
 * successfully. For instance if you were using a rest endpoint, you could execute
 * listeners like this to make sure the integration actually works.
 *
 * This is an EXAMPLE so that the command itself can run at build time, etc.
 *
 * @author oakensoul
 */
class CheckIntegration extends EventManager\AbstractListenerAggregate implements ServiceManager\ServiceLocatorAwareInterface
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

        $this->listeners[] = $pEventManager->attach(Service::EVENT_APPLICATION_CHECK_INTEGRATION, $options, 1);
        $this->listeners[] = $pEventManager->attach(Service::EVENT_APPLICATION_INITIALIZE, $options, - 50);
    }

    public function EventHandler (Console\Event $pEvent)
    {
        try
        {
            $console = $this->getServiceLocator()->get('console');

//            $config = $this->getServiceLocator()->get('Config');
//            $config = new Config($config);

            /**
             * Place code here to check whether the configured endpoints are properly integrated or not.
             */

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
