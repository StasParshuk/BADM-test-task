<?php

namespace App\Controller\Message;

use App\Message\SampleMessage;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Messenger\MessageBusInterface;
use Symfony\Component\Routing\Annotation\Route;

class SampleController extends AbstractController
{
    #[Route('/sample', name: 'sample' ,methods: "GET" ) ]
    public function sample(MessageBusInterface $bus): Response
    {
        $message = new SampleMessage('hello');
        $bus->dispatch($message);

        return $this->render('Message/show.html.twig', [
            'message' =>  sprintf('Message with content %s was published', $message->getContent()),
        ]);

    }
}
